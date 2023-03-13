# BootlegNmap
CI201 group project:  Bash Shell Script for the Network Reconnaissance Tool.
 * Output for the Ping Sweep Results
 * Output for the Port Scan Results

## Funtions:

### Main Menu Function
1. Echo the following to the screen (echo "---------- Main Menu ----------")
2. Use select loops and case statements to implement the following menu:
   * Ping Sweep
   * Port Scan
   * Print Scan Results
   * Exit Program
3. Each case statement should perform a function call to the applicable function
4. For the exit program case; developer should echo an exit related comment to the user and then exit the program using an exit 0 command.

### Ping Sweep Function
1. Echo the following to the screen (echo "---------- Ping Sweep ----------")
2. Re-direct the date to the file: pingresults.txt (Do not initialize file)
3. Prompt the user to enter in the first three number sequences of an IP address (after giving the user specific directions on how to enter the numbers (remember you will want to iterate through the final number sequence))
4. Use a for loop to iterate through each number in a subnet
5. Inside the loop:
    * Echo to the screen the IP address being pinged
    * Using a ping command inside an if statement determine if a host is active. If so identify the host as being active. Redirect this response to the pingresults.txt file
6. Outside the loop return to the Main Menu function

### Port Scan Function
1. Echo the following to the screen (echo "---------- Port Scan ----------")
2. Re-direct the date to the file: portscanresults.txt (Do not initialize file)
3. Prompt the user to enter in the IP address number for the active host that will be scanned (after giving the user specific directions on how to enter the numbers).
4. Use a for loop to iterate through port numbers on the host device
5. Inside the loop:
    * Echo to the screen the host address being scanned
    * Using an if statement determine if a port is active on the host address and if it is identify that port as being active. Redirect this response to the portscanresults.txt file
6. Outside the loop return to the Main Menu function

### Print Scan Results Function
1. Use select loops and Case statements to implement the following menu:
    * Display “Ping Sweep Results”
    * Display “Port Scan Results”
    * Remove Ping Sweep Results file
    * Remove Port Scan Results file
    * Return to Main Menu
2. In the Ping Sweep Results case Display (to the screen) the pingresults.txt file. Then return to the Print Scan Results function
3.  In the Port Scan Results case; Display (to the screen) the portscanresults.txt file. Then return to the Print Scan Results function.
4.  In the Remove Ping Sweep Results case; Remove the pingresults.txt file. Then return to the Print Scan Results function
5.  In the Remove Port Scan Results case; Remove the portscanresults.txt file. Then return to the Print Scan Results function
6.  In the Return to Main Menu case perform a function call and return to the main menu function.
