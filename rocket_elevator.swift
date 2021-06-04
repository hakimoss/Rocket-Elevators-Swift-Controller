import Swift


public class Battery {
    var ID: Int
    var status: String
    var columnsList: Array<Column>
    /* var floorRequestButtonsList: String  */
    var amountOfColumns: Int
    var amountOfFloors: Int
    var amountOfElevatorPerColumn: Int
    var amountOfBasements: Int

    init(ID: Int, amountOfColumns: Int, amountOfFloors: Int, amountOfElevatorPerColumn: Int, amountOfBasements: Int) {
        self.ID = ID
        self.status = "idle"
        self.columnsList = Array()
        /* self.floorRequestButtonsList = []  */
        self.amountOfColumns = amountOfColumns
        self.amountOfFloors = amountOfFloors
        self.amountOfElevatorPerColumn = amountOfElevatorPerColumn
        self.amountOfBasements = amountOfBasements
    }

////////////////////// CREATE COLUMN ///////////////////////    

    func createColumn(amountOfColumns: Int, amountOfFloors: Int, amountOfElevators: Int) {
        for i in 0...amountOfColumns {

            let column = Column(ID: i, amountOfFloors: amountOfFloors, amountOfElevators: amountOfElevators) 
            self.columnsList.append(column)
            self.columnsList[0].isBasement = true
            if (self.columnsList[i].isBasement == false) {
                let servedFloorMin = (i - 1) * (amountOfFloors / (self.amountOfColumns - 1));
                let servedFloorMax = i * (amountOfFloors / (self.amountOfColumns - 1));
                self.columnsList[i].servedFloors.append(0)
                self.columnsList[i].servedFloors.append(servedFloorMin)
                self.columnsList[i].servedFloors.append(servedFloorMax)
            }
            else {
                let servedFloorMin = i
                let servedFloorMax = i - self.amountOfBasements
                self.columnsList[i].servedFloors.append(0)
                self.columnsList[i].servedFloors.append(servedFloorMin)
                self.columnsList[i].servedFloors.append(servedFloorMax)
            } 

        }

    }


    func assignElevator(requestedFloor: Int, direction: String){

        // create column
        createColumn(amountOfColumns: self.amountOfColumns, amountOfFloors: self.amountOfFloors, amountOfElevators: self.amountOfElevatorPerColumn );
        // create elevator
        for i in 0...amountOfColumns {
            self.columnsList[i].createElevator(amountOfFloors: self.amountOfFloors, amountOfElevators: self.amountOfElevatorPerColumn)
        }
        let selectedColumnNumber = self.findBestColumn(requestedFloor: requestedFloor, columnsList: self.columnsList)
        print("Colone", selectedColumnNumber, "is selected")
        let selectedColumn = self.columnsList[selectedColumnNumber]

        // Set floor on scenario

        self.columnsList[1].elevatorsList[0].currentFloor = 20;
        self.columnsList[1].elevatorsList[1].currentFloor = 3;
        self.columnsList[1].elevatorsList[2].currentFloor = 13;
        self.columnsList[1].elevatorsList[3].currentFloor = 15;
        self.columnsList[1].elevatorsList[4].currentFloor = 6;

        // find best elevator

        for i in 0...self.amountOfElevatorPerColumn {
            if (selectedColumn.elevatorsList[i].currentFloor == requestedFloor) {
                selectedColumn.elevatorsList[i].floorRequestList.append(requestedFloor);
                selectedColumn.status = "busy";
                break;
            }
        }
        if (selectedColumn.status == "online") {

            for i in 0...self.amountOfElevatorPerColumn {

                if (selectedColumn.elevatorsList[i].currentFloor - requestedFloor >= -1 && selectedColumn.elevatorsList[i].currentFloor - requestedFloor <= 1) {
                    selectedColumn.elevatorsList[i].floorRequestList.append(requestedFloor);
                    selectedColumn.status = "busy";
                    break;
                }
             }
        }
        if (selectedColumn.status == "online") {

            for i in 0...self.amountOfElevatorPerColumn {

                if (selectedColumn.elevatorsList[i].currentFloor - requestedFloor >= -2 && selectedColumn.elevatorsList[i].currentFloor - requestedFloor <= 2) {
                    selectedColumn.elevatorsList[i].floorRequestList.append(requestedFloor);
                    selectedColumn.status = "busy";
                    break;
                }
             }
        }
        if (selectedColumn.status == "online") {

            for i in 0...self.amountOfElevatorPerColumn {

                if (selectedColumn.elevatorsList[i].currentFloor - requestedFloor >= -3 && selectedColumn.elevatorsList[i].currentFloor - requestedFloor <= 3) {
                    selectedColumn.elevatorsList[i].floorRequestList.append(requestedFloor);
                    selectedColumn.status = "busy";
                    break;
                }
             }
        }
        if (selectedColumn.status == "online") {

            for i in 0...self.amountOfElevatorPerColumn {

                if (selectedColumn.elevatorsList[i].currentFloor - requestedFloor >= -4 && selectedColumn.elevatorsList[i].currentFloor - requestedFloor <= 4) {
                    selectedColumn.elevatorsList[i].floorRequestList.append(requestedFloor);
                    selectedColumn.status = "busy";
                    break;
                }
             }
        }
        if (selectedColumn.status == "online") {

            for i in 0...self.amountOfElevatorPerColumn {

                if (selectedColumn.elevatorsList[i].currentFloor - requestedFloor >= -5 && selectedColumn.elevatorsList[i].currentFloor - requestedFloor <= 5) {
                    selectedColumn.elevatorsList[i].floorRequestList.append(requestedFloor);
                    selectedColumn.status = "busy";
                    break;
                }
             }
        }
        if (selectedColumn.status == "online") {

            for i in 0...self.amountOfElevatorPerColumn {

                if (selectedColumn.elevatorsList[i].currentFloor - requestedFloor >= -10 && selectedColumn.elevatorsList[i].currentFloor - requestedFloor <= 10) {
                    selectedColumn.elevatorsList[i].floorRequestList.append(requestedFloor);
                    selectedColumn.status = "busy";
                    break;
                }
             }
        }
        if (selectedColumn.status == "online") {

            for i in 0...self.amountOfElevatorPerColumn {

                if (selectedColumn.elevatorsList[i].currentFloor - requestedFloor >= -20 && selectedColumn.elevatorsList[i].currentFloor - requestedFloor <= 20) {
                    selectedColumn.elevatorsList[i].floorRequestList.append(requestedFloor);
                    selectedColumn.status = "busy";
                    break;
                }
             }
        }


        // mouvement

        for i in 0...self.amountOfElevatorPerColumn {
            if (selectedColumn.elevatorsList[i].floorRequestList.count > 0) {
                selectedColumn.elevatorsList[i].door.status = "closed";
                selectedColumn.elevatorsList[i].status = "moving";
                if (selectedColumn.elevatorsList[i].currentFloor < requestedFloor) {
                    let selectedElevator = selectedColumn.elevatorsList[i];
                    selectedElevator.direction = "up";
                    print("Elevator", selectedColumn.elevatorsList[i].ID, "is", selectedColumn.elevatorsList[i].status, selectedColumn.elevatorsList[i].direction)
                    for _ in selectedElevator.currentFloor...requestedFloor - 1 {
                        selectedElevator.currentFloor = selectedElevator.currentFloor + 1
                        print("Floor :", selectedElevator.currentFloor)
                    }
                    //// ouverture des porte  
                    selectedColumn.elevatorsList[i].door.status = "opened";
                    print("The door is", selectedColumn.elevatorsList[i].door.status)
                }
                else if (selectedColumn.elevatorsList[i].currentFloor > requestedFloor) {
                    let selectedElevator = selectedColumn.elevatorsList[i];
                    selectedElevator.direction = "down";
                    print("Elevator", selectedColumn.elevatorsList[i].ID, "is", selectedColumn.elevatorsList[i].status, selectedColumn.elevatorsList[i].direction)
                    for _ in requestedFloor...selectedElevator.currentFloor - 1 {
                        selectedElevator.currentFloor = selectedElevator.currentFloor - 1
                        print("Floor :", selectedElevator.currentFloor)
                    }
                    //// ouverture des porte  
                    selectedColumn.elevatorsList[i].door.status = "opened";
                    print("The door is", selectedColumn.elevatorsList[i].door.status)
                }
                else {
                    selectedColumn.elevatorsList[i].door.status = "opened";
                    print("The door is", selectedColumn.elevatorsList[i].door.status)

                }
            }
              
                    
        }



    }

////////////////////////////// FIND BEST COLUMN //////////////////////////////

    func findBestColumn(requestedFloor: Int, columnsList: Array<Column> ) -> Int {
        for i in 1...columnsList.count - 1 {
            if (columnsList[i].servedFloors[1] <= requestedFloor && columnsList[i].servedFloors[2] >= requestedFloor || columnsList[i].servedFloors[1] >= requestedFloor && columnsList[i].servedFloors[2] <= requestedFloor){    
                let selectedColumn = i
                return selectedColumn
            } 
        }
        return 0
    }

}

public class Column {
    var ID: Int
    var status: String
    var servedFloors: [Int]
    var isBasement: Bool
    var elevatorsList: Array<Elevator>
    /* var callButtonsList: Int */
    var amountOfElevators: Int

    init(ID: Int, amountOfFloors: Int, amountOfElevators: Int) {
        self.ID = ID
        self.status = "online"
        self.servedFloors = [Int]()
        self.isBasement = false
        self.elevatorsList = Array()
        /* self.callButtonsList = [] */
        self.amountOfElevators = amountOfElevators   
    }

////////////////////////////// Create ELEVATOR //////////////////////////////     

    func createElevator(amountOfFloors: Int, amountOfElevators: Int){
        for i in 0...amountOfElevators {
        let elevator = Elevator(ID: i, amountOfFloors: amountOfFloors) 
        self.elevatorsList.append(elevator)
        }
    }



////////////////////////////// requestElevator //////////////////////////////    

    func requestElevator(requestedFloor: Int, direction: String) {
        for i in 0...self.amountOfElevators {
            if (self.elevatorsList[i].floorRequestList.count > 0) {
                if (self.elevatorsList[i].currentFloor < requestedFloor) {
                    self.elevatorsList[i].door.status = "closed";
                    print("The door is", self.elevatorsList[i].door.status)
                    let selectedElevator = self.elevatorsList[i]
                    selectedElevator.direction = "up";
                    print("Elevator", self.elevatorsList[i].ID, "is", self.elevatorsList[i].status, self.elevatorsList[i].direction)
                    for _ in selectedElevator.currentFloor...requestedFloor - 1 {
                        selectedElevator.currentFloor = selectedElevator.currentFloor + 1
                        print("Floor :", selectedElevator.currentFloor)
                    }
                    //// ouverture des porte  
                    self.elevatorsList[i].door.status = "opened";
                    print("The door is", self.elevatorsList[i].door.status)
                } else {
                    self.elevatorsList[i].door.status = "closed";
                    print("The door is", self.elevatorsList[i].door.status)
                    let selectedElevator = self.elevatorsList[i]
                    selectedElevator.direction = "down";
                    print("Elevator", self.elevatorsList[i].ID, "is", self.elevatorsList[i].status, self.elevatorsList[i].direction)
                    for _ in requestedFloor...selectedElevator.currentFloor - 1 {
                        selectedElevator.currentFloor = selectedElevator.currentFloor - 1
                        print("Floor :", selectedElevator.currentFloor)
                    }
                     //// ouverture des porte  
                    self.elevatorsList[i].door.status = "opened";
                    print("The door is", self.elevatorsList[i].door.status)
                }
            }
        }
    }

}

public class Elevator {
    var ID: Int
    var status: String
    var currentFloor: Int
    var direction: String
    var door: Door 
    var floorRequestList: [Int]
    /* var completedRequestsList: Int */
    
/* let column = Column */
    init(ID: Int, amountOfFloors: Int) {
        self.ID = ID
        self.status = "idle"
        self.currentFloor = 0
        self.direction = "idle"
        self.door = Door(ID: ID)
        self.floorRequestList = [Int]()
        /* self.completedRequestsList = []    */
    }
}

public class Door {
    var ID: Int
    var status: String
    
    init(ID: Int) {
        self.ID = ID
        self.status = "opened"  
    }
}

public class CallButton {
    var ID: Int
    var status: String
    var floor: Int
    var direction: String
    
    init(ID: Int, floor: Int, direction: String) {
        self.ID = ID
        self.status = "idle"  
        self.floor = floor
        self.direction = direction 
    }
}

public class FloorRequestButtons {
    var ID: Int
    var status: String
    var floor: Int
    
    init(ID: Int, floor: Int) {
        self.ID = ID
        self.status = "idle"  
        self.floor = floor
    }
}



var battery1 = Battery(ID: 1, amountOfColumns: 4, amountOfFloors: 60, amountOfElevatorPerColumn: 5, amountOfBasements: 6) 
battery1.assignElevator(requestedFloor: 2, direction: "up")
battery1.columnsList[1].requestElevator(requestedFloor: 13, direction: "down");
