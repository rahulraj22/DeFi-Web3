import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Time "mo:base/Time";
import Float "mo:base/Float";
actor DBank {
  stable var currentValue: Float = 300;
  currentValue := 300; /* for reassigning the value of variable we use := instead of just using = */
  Debug.print(debug_show(currentValue));

  // 35.7: Tracking Time 
  stable var startTime = Time.now();
  // startTime := Time.now();
  Debug.print(debug_show(startTime));

  let id = 25215918235123523;  /* for const variable in js, in motoko we use let */
  // id := 12934818235123;  /* we can't do this, as stated above. */
  // Debug.print(debug_show(currentValue));
  // Debug.print("Hello"); // It get's printed (becoz it prints text only)
  // Debug.print(debug_show(id));

  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  // 35.3: Challenge: 
  // Allow users to withdraw an amount from the currentValue
  // Decrease the currentValue by the amount
  public func withdraw(amount: Float){
    let tempValue: Float = currentValue - amount;
    // to avoid Error: Natural Substraction Underflow
    if(tempValue >= 0){
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    }else{
      Debug.print("Amount too large, currentValue is less than zero");
    }
  };

  // 35.5: Query & Updates Method
  // Query: this function will allow us to quickly view the currentValue
  public query func checkBalance(): async Float {
    return currentValue;
  };

  // topUp();

  public func compound(){
    let currentTime = Time.now();
    let timeElapsed_In_NS = currentTime - startTime;
    let timeElapsed_In_S = timeElapsed_In_NS / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsed_In_S));
    startTime := currentTime;
  }
}
//   http://127.0.0.1:4943/?canisterId=r7inp-6aaaa-aaaaa-aaabq-cai