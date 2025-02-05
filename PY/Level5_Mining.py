import sys

def main():
    args = sys.argv
    try:
        Mining(args[1])
    except:
        print('Write some code!') 

def Mining(user_code):
    local = {}
    correct = True
    try:
        user_code = "inventory = ['pickaxe', 'bag']\nchecker =[]\ndef hit(tool):\n\tchecker.append(tool)\ndef collect(tool):\n\tchecker.append(tool)\n" + user_code
        exec(user_code, local)
        try:
            checker = local['checker']
            if len(checker) != 2:
                correct = False
                print("The hit function must be called twice within your startMining function")
            if checker[0] != 'pickaxe' or checker[1]!= 'bag':
                correct = False
                print("Assign variable tool to 'pickaxe' (0th index in the inventory array)")
        except:
            correct = False
    except Exception as error:
        print("Error: ", error)
        correct = False
    if correct:
        print('You can now mine the rocks')
    else:
        print('wrong')
        
if __name__ == "__main__":
    main()