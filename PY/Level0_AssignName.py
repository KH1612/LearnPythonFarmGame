import sys

def main():
    args = sys.argv
    try:
        farm_name(args[1])
    except:
        print('Write some code!') 

def farm_name(user_code):
    local = {}
    correct = True
    try:
        exec(user_code, local)
        try:
            name = local['name']
        except:
            print("Use the name variable!")
            correct = False
        

    except Exception as error:
        print("Error: ", error)
        correct = False
        
    if correct:
        print('Your farm has been named')
    else:
        print('wrong')

if __name__ == "__main__":
    main()