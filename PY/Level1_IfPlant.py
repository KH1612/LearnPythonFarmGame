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
            radishPlanted = local['radishPlanted']
            sunflowerPlanted = local['sunflowerPlanted']

            if not radishPlanted:
                correct = False
            if sunflowerPlanted:
                correct = False

        except:
            print('Make sure radishPlanted and sunflowerPlanted are defined')
            correct = False
    except Exception as error:
        print("Error: ", error)
        correct = False
    if correct:
        print("Close the console to see your planting!")
    else:
        print("wrong")
        
if __name__ == "__main__":
    main()