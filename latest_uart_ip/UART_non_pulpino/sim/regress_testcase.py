import re
import os
import sys

def check_uvm_log(input_log, output_log):
    """
    Checks a log file for UVM_ERROR and UVM_FATAL counts and reasons, along with the test case name.
    Writes "TESTCASE FAILED" if counts > 1, else "TESTCASE PASSED" in the output log file.
    If the output log file already exists, appends the results to it.
    
    Parameters:
        input_log (str): Path to the input log file.
        output_log (str): Path to the output log file to write results.
    """
    uvm_error_count = 0
    uvm_fatal_count = 0
    uvm_error_reasons = []
    uvm_fatal_reasons = []
    testcase_name = "Unknown"

    # Read the input log file
    try:
        with open(input_log, 'r') as log_file:
            for line in log_file:
                # Stop processing if report summary is reached
                if "--- UVM Report Summary ---" in line:
                    report_summary_reached = True
                    break

                # Look for the test case name
                if "+UVM_TESTNAME=" in line:
                    match = re.search(r"\+UVM_TESTNAME=([\w_]+)", line)
                    if match:
                        testcase_name = match.group(1)
                # Look for lines containing UVM_ERROR and UVM_FATAL
                if "UVM_ERROR" in line:
                    match = re.search(r"UVM_ERROR\s*(.*)", line)
                    if match:
                        uvm_error_count += 1
                        uvm_error_reasons.append(match.group(1).strip())
                elif "UVM_FATAL" in line:
                    match = re.search(r"UVM_FATAL\s*(.*)", line)
                    if match:
                        uvm_fatal_count += 1
                        uvm_fatal_reasons.append(match.group(1).strip())
    except FileNotFoundError:
        print(f"Error: The file {input_log} does not exist.")
        return

    # Determine test case result
    test_status = "PASSED"
    if uvm_error_count == 1 or uvm_fatal_count == 1:
        test_status = "FAILED"

    count_passed = 0
    count_failed = 0

    # Write or append to the output log file
    write_mode = 'a' if os.path.exists(output_log) else 'w'
    with open(output_log, write_mode) as output_file:
        output_file.write(f"Test Case: {testcase_name} --> {test_status}\n")

        if(test_status == "PASSED"):
            output_file.write("\n" + "-"*50 + "\n\n")  # Separator between entries
            count_passed += 1

        for reason in uvm_error_reasons:
            output_file.write(f"\nUVM_ERROR : {reason}\n")
            output_file.write("\n" + "-"*50 + "\n\n")  # Separator between entries
            count_failed += 1

        for reason in uvm_fatal_reasons:
            output_file.write(f"\nFATAL : {reason}\n")
            output_file.write("\n" + "-"*50 + "\n\n")  # Separator between entries
            count_failed += 1

    # Write or append to the output log file
    #write_mode = 'a'
    #with open(output_log, write_mode) as output_file:
       # output_file.write(f"\n\nTOTAL TESTCASES PASSED = {count_passed}\n TOTAL TESTCASES FAILED = {count_failed}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <input_log_file> [<output_log_file>]")
        sys.exit(1)

    input_log_file = sys.argv[1]
    output_log_file = sys.argv[2] if len(sys.argv) > 2 else "Regression_Report.log"

    check_uvm_log(input_log_file, output_log_file)
    print(f"Regression testcases report is generated : {output_log_file}")
