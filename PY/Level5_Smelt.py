import sys

def main():
    args = sys.argv
    try:
        Smelt(args[1])
    except:
        print('Write some code!') 

def Smelt(user_code):
    local = {}
    correct = True
    try:
        user_code = "bag = ['coal','gold', 'gold', 'gold','diamond', 'diamond']\n" + user_code
        exec(user_code, local)

    except Exception as error:
        print("Error: ", error)
        correct = False
    if correct:
        print('Smelting has been started!')
    else:
        print('wrong')
        
if __name__ == "__main__":
    main()