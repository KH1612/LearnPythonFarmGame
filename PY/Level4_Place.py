import sys

def main():
    args = sys.argv
    try:
        Place(args[1])
    except:
        print('Write some code!') 

def Place(user_code):
    
    local = {}
    try:
        exec(user_code, local)
        correct = True
        try:
            appleBox = local['appleBox']
            orangeBox = local['orangeBox']
            place = local['Place']

            if not callable(place):
                correct = False
                print("Make sure you have a Place() function")
            if len(appleBox) != 4 or len(orangeBox) != 4:
                print('Check your if statement again')
                correct = False
            for x,y in zip(appleBox, orangeBox):
                if x != 'apple':
                    print('Your apple condition is incorrect')
                if y != 'orange':
                    print('Your orange condition is incorrect')

        except:
            correct = False
            print('Make sure you have arrays appleBox and orangeBox')
    except Exception as error:
        print("Error: ", error)
        correct = False
    if correct:
        print("The fruits have been placed in the correct boxes")
    else:
        print("wrong")
        
if __name__ == "__main__":
    main()