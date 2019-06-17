import UIKit

var dateString = ""

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var MonthLabel: UILabel!
    
    
    let Months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    let DaysOfMonth = ["Monday","Thuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    var DaysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    var currentMonth = String()
    
    var NumberOfEmptyBox = Int()
    
    var NextNumberOfEmptyBox = Int()
    
    var PreviousNumberOfEmptyBox = 0
    
    var Direction = 0
    
    var PositionIndex = 0
    
    var LeapYearCounter = 2
    
    var dayCounter = 0
    
    var highlightdate = -1
    
    var datemonth = ""
    
    var dateday = ""
    
    var datecode = ""
    
    var cellsArray : [UICollectionViewCell] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Your Date"
        currentMonth = Months[month]
        self.MonthLabel.text = "\(currentMonth) \(year)"
        if weekday == 0 {
            weekday = 7
        }
        GetStartDateDayPosition()
    }
    
    //-----------(Calculates the number of "empty" boxes at the start of every month")------------------------------------------------------
    
    func GetStartDateDayPosition() {
        switch Direction{
        case 0:
            NumberOfEmptyBox = weekday
            dayCounter = day
            while dayCounter>0 {
                NumberOfEmptyBox = NumberOfEmptyBox - 1
                dayCounter = dayCounter - 1
                if NumberOfEmptyBox == 0 {
                    NumberOfEmptyBox = 7
                }
            }
            if NumberOfEmptyBox == 7 {
                NumberOfEmptyBox = 0
            }
            PositionIndex = NumberOfEmptyBox
        case 1...:
            NextNumberOfEmptyBox = (PositionIndex + DaysInMonths[month])%7
            PositionIndex = NextNumberOfEmptyBox
            
        case -1:
            PreviousNumberOfEmptyBox = (7 - (DaysInMonths[month] - PositionIndex)%7)
            if PreviousNumberOfEmptyBox == 7 {
                PreviousNumberOfEmptyBox = 0
            }
            PositionIndex = PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    //--------------------------------------------------(Next and back buttons)-------------------------------------------------------------
    @IBAction func Next(_ sender: Any) {
        highlightdate = -1
        switch currentMonth {
        case "December":
            Direction = 1
            
            month = 0
            year += 1
            
            if LeapYearCounter  < 5 {
                LeapYearCounter += 1
            }
            
            if LeapYearCounter == 4 {
                DaysInMonths[1] = 29
            }
            
            if LeapYearCounter == 5{
                LeapYearCounter = 1
                DaysInMonths[1] = 28
            }
            GetStartDateDayPosition()
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            
            MoveAnimationNext(Label: MonthLabel)
            
            Calendar.reloadData()
        default:
            Direction = 1
            
            GetStartDateDayPosition()
            
            month += 1
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            MoveAnimationNext(Label: MonthLabel)
            Calendar.reloadData()
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        highlightdate = -1
        switch currentMonth {
        case "January":
            Direction = -1
            
            month = 11
            year -= 1
            
            if LeapYearCounter > 0{
                LeapYearCounter -= 1
            }
            if LeapYearCounter == 0{
                DaysInMonths[1] = 29
                LeapYearCounter = 4
            }else{
                DaysInMonths[1] = 28
            }
            
            GetStartDateDayPosition()
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            MoveAnimationBack(Label: MonthLabel)
            Calendar.reloadData()
            
        default:
            Direction = -1
            
            month -= 1
            
            GetStartDateDayPosition()
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            MoveAnimationBack(Label: MonthLabel)
            Calendar.reloadData()
        }
    }
    
    
    //----------------------------------(CollectionView)------------------------------------------------------------------------------------
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direction{
        case 0:
            return DaysInMonths[month] + NumberOfEmptyBox
        case 1...:
            return DaysInMonths[month] + NextNumberOfEmptyBox
        case -1:
            return DaysInMonths[month] + PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        
        cell.DateLabel.textColor = UIColor.black
        
        cell.Circle.isHidden = true
        
        if cell.isHidden{
            cell.isHidden = false
        }
        
        switch Direction {      //the first cells that needs to be hidden (if needed) will be negative or zero so we can hide them
        case 0:
            cell.DateLabel.text = "\(indexPath.row + 1 - NumberOfEmptyBox)"
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - NextNumberOfEmptyBox)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PreviousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.DateLabel.text!)! < 1{ //here we hide the negative numbers or zero
            cell.isHidden = true
        }
        
        switch indexPath.row { //weekend days color
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.DateLabel.text!)! > 0 {
                cell.DateLabel.textColor = UIColor.lightGray
            }
        default:
            break
        }
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 - NumberOfEmptyBox == day{
            cell.Circle.isHidden = false
            cell.DrawCircle()
            
        }
        
        if highlightdate == indexPath.row{
            
            cell.backgroundColor = UIColor.blue
        }
        
        cellsArray.append(cell)
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        dateString = "\(indexPath.row - PositionIndex + 1) \(currentMonth) \(year)"
        
        //performSegue(withIdentifier: "NextView", sender: self)
        
        dateday = convertdate(date: "\(indexPath.row - PositionIndex + 1)")
        
        datemonth = convertdate(date: String(Months.firstIndex(of: currentMonth)!+1))
        
        datecode = datemonth + "%2F" + dateday + "%2F" + "\(year)"
        
        let viewc2 = storyboard?.instantiateViewController(withIdentifier: "EventTableViewController") as? EventTableViewController
        
        viewc2?.title = dateString
        viewc2?.encodedate = datecode
        
        self.navigationController?.pushViewController(viewc2!, animated: true)
        highlightdate = indexPath.row
        collectionView.reloadData()
    }
    
    
    private func convertdate(date: String) -> String{
        
        let size = date.count
        var ans = ""
        
        if( size == 1){
            ans = "0" + date
        }
        else{
            ans = date
        }
        return ans
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5,0.5,0.5)
        
        for x in cellsArray{
            let cell : UICollectionViewCell = x
            
            UIView.animate(withDuration: 1, delay: 0.01 * Double(indexPath.row), usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseOut, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
        }
    }
}
    


