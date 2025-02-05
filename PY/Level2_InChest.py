import sys
def main():
    args = sys.argv
    try:
        Collect(args[1])
    except:
        print('Write some code!') 

def Collect(user_code):
    local = {}
    try:
        user_code = "eggs = [True, True, True, True, True]\nchest = [False, False, False, False, False]\n" + user_code
        exec(user_code, local)
        correct = True
        
        try:
            chest = local['chest']
            for x in chest:
                if x != True:
                    correct = False
                    print('There should be 5 reassignment statements (0-4)')
                    print('Example: chest[1] = eggs[1]')

        except:
            correct = False
            print('Array must be called chest')
    except Exception as error:
        print("Error: ", error)
        correct = False

    if correct:
        print("Eggs have been placed in the chest.")
    else:
        print("wrong")
        
if __name__ == "__main__":
    main()

