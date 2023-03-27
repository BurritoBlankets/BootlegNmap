#/bin/bash
###############################################################################
#File:      Bootleg.sh
#Author:    Jose (Pillo) Duenas-Lopez & Jane Mcclure
#Info:
#           CI201 group project: A simple bash script that performs ping sweep
#           and port scans.
#
#Class:     CI 201 @ 1200-1250 (M,W,F)
#
#Notes:
#           work on find and replace (sed or awk)
#https://erau.instructure.com/courses/151725/assignments/3043432
###############################################################################


function main_menu () {
    echo "-------------- Main Menu ---------------"
    select choice in 'Ping Sweep' 'Port Scan' 'Print Scan Results' 'Exit Program'
    do
        case $choice in
            'Ping Sweep')
                ping_sweep
                ;;
            'Port Scan')
                port_scan
                ;;
            'Print Scan Results')
                print_scan_results
                ;;
            'Exit Program')
                echo "Exiting Program"
                exit
                ;;
            *)
                echo "ERROR: Not a valid option"
                ;;
        esac
    done
}


function ping_sweep () {
    echo "-------------- Ping Sweep --------------"
    echo $(date) >> pingresults.txt

    valid_ip_adress=0

    while [[ $valid_ip_adress == 0 ]]
    do
        echo -n "IPv4 Address: "
        read ip_address

        if echo $ip_address | grep -E '^([0-9]{1,3}[.]){3}[0-9]{1,3}$'
        then
            ((valid_ip_adress++))
        else
            echo "ERROR: Invalid IPv4 address, try 8.8.8.8"
        fi
    done

    ip_address=$(echo $ip_address | grep -Eo '^([0-9]{1,3}[.]){3}')
    for i in {1..256}
    do
        echo -en "\nScanning: $ip_address$i; "
        ping_ip=$(echo )
        if ping -c1 "$ip_address$i" >2
        then
            echo -n " Status: ONLINE"
            echo "$ip_address$i; Status: ONLINE" >> pingresults.txt
        fi
    done
    main_menu
}


function port_scan () {
    echo "-------------- Port Scan ---------------"
    echo $(date) >> portscanresults.txt

    valid_ip_adress=0

    while [[ $valid_ip_adress == 0 ]]
    do
        echo -n "IPv4 Address: "
        read ip_address

        if echo $ip_address | grep -E '^([0-9]{1,3}[.]){3}[0-9]{1,3}$'
        then
            ((valid_ip_adress++))
        else
            echo "ERROR: Invalid IPv4 address, try 8.8.8.8"
        fi
    done

    ip_address=$(echo $ip_address | grep -Eo '^([0-9]{1,3}[.]){3}[0-9]{1,3}$')
    for i in {0..1023}
    do
        echo -en "\nScanning: $ip_address:$i; "
        ping_ip=$(echo )
        if ping -c1 "$ip_address$i" >2
        then
            echo -n " Status: ONLINE"
            echo "$ip_address$i; Status: ONLINE" >> ping_sweep.txt
        fi
    done
    main_menu
}

function print_scan_results () {
    echo "---------- Print Scan Results ----------"
    select choice in 'Ping Sweep Results' 'Port Scan Results' 'Remove Ping Sweep Results File' 'Remove Port Scan Results File' 'Return to Main Menu'
    do
        case $choice in
            'Ping Sweep Results')
                cat pingresults.txt
                ;;
            'Port Scan Results')
                cat portscanresults.txt
                ;;
            'Remove Ping Sweep Results File')
                rm pingresults.txt
                ;;
            'Remove Port Scan Results File')
                rm portscanresults.txt
                ;;
            'Return to Main Menu')
                main_menu
                ;;
            *)
                echo "ERROR: Not a valid option"
                ;;
        esac
    done

}

main_menu
