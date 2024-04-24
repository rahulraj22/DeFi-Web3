import { dbank } from '../../declarations/dbank/index'

// get's called once all of the content of pages is finished loading.
window.addEventListener("load", async function(){
  // console.log("Finished Loading");
  /*
  const currentAmt = await dbank.checkBalance();
  // to get 2 decimal place of accuracy
  // 1. using toFixed(2) function
  // 2. simple round function
  docuement.getElementById("value").innerText = Math.round(currentAmt * 100) / 100;
  */
  update();
});

document.querySelector("form").addEventListener("submit", async function(event) {
  event.preventDefault(); // to prevent auto-refresh of form on submit
  console.log("Submitted...");

  const button = event.target.querySelector("#submit-btn");

  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  button.setAttribute("disabled", true);

  if(document.getElementById("input-amount").value.length != 0){
    await dbank.topUp(inputAmount);
  }

  // withdrawal function
  if(document.getElementById("withdrawal-amount").value.length != 0){
    await dbank.withdraw(outputAmount);
  }

  // Compound function
  await dbank.compound();

  update();

  document.getElementById("input-amount").value = "";
  document.getElementById("withdraw-amount").value = "";

  button.removeAttribute("disabled");
});

async function update(){
  const currentAmt = await dbank.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmt * 100) / 100;
}