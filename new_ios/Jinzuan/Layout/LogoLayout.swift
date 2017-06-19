import UIKit

class LogoLayout : UIView{
    var logo:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        logo = UIImageView(frame: frame);
        logo.image = UIImage(named: "eb畫面.jpg")
        addSubview(logo);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

