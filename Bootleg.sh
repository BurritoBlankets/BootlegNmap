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
###############################################################################


function main_menu () {
    echo -e "\n-------------- Main Menu ---------------"
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
                date &> /dev/null
                exit
                ;;
            *)
                echo "ERROR: Not a valid option"
                ;;
        esac
    done
}


function ping_sweep () {
    echo -e "\n-------------- Ping Sweep --------------"
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
            echo "ERROR: Invalid IPv4 address, try 1.1.1.1"
        fi
    done
    #Reads in IPv4 address using regex to ensure user enters a valid IPv4 format

    ip_address=$(echo $ip_address | grep -Eo '^([0-9]{1,3}[.]){3}')
    #Parses first 3 bytes of the IP address

    for i in {1..255}
    do
        echo -en "\nScanning: $ip_address$i; "
        if ping -c1 -W0.1 "$ip_address$i" >2
        #In English: if a successful ping is found within 0.1 seconds of ${ip_addy} then...
        then
            echo -n " Status: ONLINE"
            echo "$ip_address$i; Status: ONLINE" >> pingresults.txt
        fi
    done
    #Ulitlizes a for loop to search if the status of every port
    main_menu
}


function port_scan () {
    echo -e "\n-------------- Port Scan ---------------"
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
            echo "ERROR: Invalid IPv4 address, try 1.1.1.1"
        fi
    done
    #Reads in IPv4 address using regex to ensure user enters a valid IPv4 format

    ip_address=$(echo $ip_address | grep -Eo '^([0-9]{1,3}[.]){3}[0-9]{1,3}$')
    #Parses first 3 bytes of the IP address

    for i in {1..500}
    do
        echo -en "\nScanning port $i on $ip_address; "
        if nc -z -v -w1 $ip_address $i 2>&1 | grep -q 'succeeded'
            #In English: if the output of netcat z (portscan), v(verbose) w1 (with a time restriction of 1 second) for ip addy at whatever port includes the word 'succeeded' (meaning port was open), then...
        then
            echo -n " Status: ONLINE"
            echo "$ip_address$i; Status: ONLINE" >> portscanresults.txt
        fi

    done

    main_menu
}


function print_scan_results () {
    echo -e "\n---------- Print Scan Results ----------"
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
