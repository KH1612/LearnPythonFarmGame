import sys

def main():
    args = sys.argv
    try:
        inventory(args[1])
    except:
        print('Write some code!') 

def inventory(user_code):
    local = {}
    try:
        exec(user_code, local)
        correct = True

        try:
            inventory = local['inventory']
            for i in range(0,3):
                inventory.append('')
            if inventory[0] != 'pickaxe':
                print("Index 0 should be a pickaxe")
                correct = False
            if inventory[1] != 'bag':
                print("Index 1 should be a bag")
                correct = False
            if inventory[2] != 'matches':
                print("Index 2 should be a matches")
                correct = False
            if correct:
                print("Inventory is correct")

        except:
            print("Name your array 'inventory'")

    except Exception as error:
        print("Error: ", error)
        correct = False
        
if __name__ == "__main__":
    main()