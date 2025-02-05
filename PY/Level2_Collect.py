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
        exec(user_code, local)
        correct = True
        try:
            eggs = local['eggs']
            if len(eggs) != 5:
                correct = False
                print('Use .append() 5 times')
            for x in eggs:
                if x != True:
                    correct == False
                    print('Use .append(True)')

        except:
            correct = False
            print('Array must be called eggs')
    except Exception as error:
        print("Error: ", error)
        correct = False
    if correct:
        print("Eggs are ready to be collected in the chicken pen")
    else:
        print("wrong")
        
if __name__ == "__main__":
    main()