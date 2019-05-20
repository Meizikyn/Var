root=D:\EIC

function initialize {
    $LOCK=0
    $USER=root
    $REGISTRY=0
    $SECURITY=0
    $LINK=game
    $MODE=0

    optspec=":u:r:pl:-:"
    while getopts "$optspec" optchar; do
        case "${optchar}" in
            -)
                case "${OPTARG}" in
                    user=*)
                        val=${OPTARG#*=}
                        opt=${OPTARG%=$val}
                        ;;
                    registry=-*)
                        val=${OPTARG#*=}
                        opt=${OPTARG%=$val}
                        echo "Parsing option: '--${opt}', value: '${val}'" >&2
                        ;;
                    private)
                        val=${OPTARG#*=}
                        opt=${OPTARG%=$val}
                        ;;
                    link=*)
                        val=${OPTARG#*=}
                        opt=${OPTARG%=$val}
                        ;;
                    *)
                        if [ "$OPTERR" = 1 ] && [ "${optspec:0:1}" != ":" ]; then
                            echo "Unknown option --${OPTARG}" >&2
                        fi
                        ;;
                esac;;
            u)
                user=${OPTARG}
                ;;
            r)
                registry=${OPTARG}
                ;;
            p)
                private=1
                ;;
            l)
                link=${OPTAR-G}
                ;;
            *)
                if [ "$OPTERR" != 1 ] || [ "${optspec:0:1}" = ":" ]; then
                    echo "Non-option argument: '-${OPTARG}'" >&2
                fi
                ;;
        esac
    done

    #== Check Ramdisk
    if ! touch $root/run/node; then
        mount-ramdisk
    fi

    #== Check Run Path
    if [[ $private == 1 ]]; then
        run=$root/run/user/$user
        spin=0
    else
        run=$root/run/global
        spin=1
    fi

    if [[ $spin == 1 ]]; then
        sname=${ls $run/sid/free | head -n 1}
        if [[ ! $sname ]]; then
            sname=${ls $run/sid/lock | head -n 1}
        fi
    else
        sname=${ls $run/sid/lock | head -n 1}
    fi





function mount-ramdisk {
    if [[ ! -d $root/run ]]; then
        mkdir $root/run
        imdisk -a -t vm -s 64m -m $root/run -p "/fs:ntfs /q /y"
        cp -a $root/config/skeleton/run/* $root/run
        cp $root/config/sids/public/* $root/run/global/sid/free
    fi
}


function hive
