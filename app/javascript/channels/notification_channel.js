import consumer from "./consumer"
import toastr from "toastr"

consumer.subscriptions.create("NotificationChannel", {
  received(data) {
    console.log(123123, data);
    if (typeof toastr !== 'undefined') {
      toastr.success(data.message);
      setTimeout(() => {
        window.location.reload();
      }, 5000); 
    } else {
      console.error('Toastr is not defined.');
    }
  }
});