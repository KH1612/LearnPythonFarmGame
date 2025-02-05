import sys

def main():
    args = sys.argv
    try:
        lampLight(args[1])
    except:
        print('Write some code!') 

def lampLight(user_code):
    local = {}
    user_code = "inventory = ['pickaxe', 'bag', 'matches']\n" + user_code 
    correct = True
    try:
        exec(user_code, local)
        try:
            tool = local['tool']
            inventory = local['inventory']
            if len(inventory) !=2:
                print('Make sure you used .pop()')
                correct = False
            if tool != 'matches':
                print("Incorrect tool, make sure to used matches in index 2")
                correct = False

        except:
            print("You haven't got a variable called tool")
            correct = False

    except Exception as error:
        print("Error: ", error)
        correct = False
    if correct:
        print("The lamps have been lit")
    else:
        print('wrong')
        
if __name__ == "__main__":
    main()