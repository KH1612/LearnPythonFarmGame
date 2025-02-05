import sys

def main():
    args = sys.argv
    try:
        Harvest(args[1])
    except:
        print('Write some code!') 

def Harvest(user_code):
    
    local = {}
    try:
        exec(user_code, local)
        correct = True
        try:
            hit = local['Hit']
            collect = local['Collect']
            bag = local['bag']
            if not callable(hit) and not callable(collect):
                correct = False
                print('Make sure to declare your functions correctly')
            if len(bag) != 8:
                print('for loop must run 8 times (make sure to call Collect(Bag) in Hit())')
                correct = False
            for x in bag:
                if x != 'Fruit':
                    correct = False
                    print('Make sure to call the collect function in Hit()')  
        except:
            print('Make sure you have a Hit() and Collect(bag) function')
            correct = False
    except Exception as error:
        print("Error: ", error)
        correct = False
    if correct:
        print("Fruit trees are ready to be chopped")
    else:
        print("wrong")
        
if __name__ == "__main__":
    main()
