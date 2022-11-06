
import UIKit
import CountryPickerView


/*
 
class CountryPickerVC: UIViewController {
   
    
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var tfCountrycode: UITextField!
    
    
    let countryPickerView = CountryPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        countryPickerView.delegate = self
        
        //MARK: Set default country
        if GConstant.signUpUser.country_code == ""{
            if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
                print(countryCode)
                let defaultCountry = countryPickerView.getCountryByCode(countryCode)
                self.imgFlag.image = defaultCountry?.flag
            }
        }else{
            self.imgFlag.image = GConstant.signUpUser.countryFlag
        }


    }
    
    
    @IBAction func btnCountryPickerAction(_ sender: Any) {
        self.countryPickerView.showCountriesList(from: self)

    }
}

extension CountryPickerVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        imgFlag.image = country.flag
       print("\(country.flag)")
        print("\(country.phoneCode)")
    }
    
    func countryPickerView(_ countryPickerView: CountryPickerView, willShow viewController: CountryPickerViewController) {
        
    }
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didShow viewController: CountryPickerViewController) {
        
    }
}
 
 

 */
