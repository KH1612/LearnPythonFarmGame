import sys

def main():
    args = sys.argv
    try:
        Place(args[1])
    except:
        print('Write some code!') 

def Place(user_code):
    user_code = "pumpkins = []\nfor i in range(56):\n\tpumpkins.append(True)\n"
    local = {}
    try:
        exec(user_code, local)
        correct = True
        try:
            pumpkins = local['pumpkins']
            chest = local['chest']
            for x in chest:
                if x != True:
                    correct = False
                    print("?")
            if len(chest) != 56 or len(pumpkins) != 0:
                correct = False
                print("?")
        except:
            pass
    except Exception as error:
        print("Error: ", error)
        correct = False
    if correct:
        print("Pumpkins moved to chest")
    else:
        print("wrong")
        
if __name__ == "__main__":
    main()