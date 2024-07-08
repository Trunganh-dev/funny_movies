document.addEventListener('DOMContentLoaded', function () {
    const showNotification = (message) => {
      const popup = document.getElementById('notification-popup');
      popup.textContent = message;
      popup.style.display = 'block';
  
      setTimeout(() => {
        popup.style.display = 'none';
      }, 5000);
    };
  
    // Example usage:
    // showNotification('This is a notification message!');
    
    // If you want to trigger this notification from Rails controller:
    // Use the following ERB code in your Rails view or layout:
    // <%= javascript_tag "showNotification('#{j notice}')" if notice.present? %>
    // <%= javascript_tag "showNotification('#{j alert}')" if alert.present? %>
  });
  