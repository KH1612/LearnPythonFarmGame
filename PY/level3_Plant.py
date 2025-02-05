import sys

def main():
    args = sys.argv
    try:
        Plant(args[1])
    except:
        print('Write some code!') 

def Plant(user_code):
    local = {}
    pumpkins =[]
    try:
        exec(user_code, local)
        correct = True
        try:
            pumpkins = local['pumpkins']
            for x in pumpkins:
                if x != True:
                    correct = False
                    print("Use .append(True)")
            if len(pumpkins) != 56:
                correct = False
                print("Make sure to loop 56 times (range(56))")
        except:
            pass
    except Exception as error:
        print("Error: ", error)
        correct = False
    if correct:
        print("Planting...")
    else:
        print("wrong")
        
if __name__ == "__main__":
    main()