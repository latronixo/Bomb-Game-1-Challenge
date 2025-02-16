import Foundation

@propertyWrapper
public struct UserDefault<Value> {
    private let key: String
    private let defaultValue: Value
    
    public init(key: String, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: Value {
        get {
            (UserDefaults.standard.object(forKey: self.key) as? Value) ?? self.defaultValue
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: self.key)
        }
    }
    
    public var projectedValue: Self {
        get { return self }
    }
    
    public func removeValue() {
        UserDefaults.standard.removeObject(forKey: self.key)
    }
}
