// This script is just for demonstration to show the buttons are clickable.
// In your real project, these would link to your JSP/Servlet pages.

document.getElementById('signInBtn').addEventListener('click', function() {
    console.log('Sign In button clicked. Redirecting to login page...');
    // window.location.href = '/login.jsp'; // Example redirect
});

document.getElementById('signUpBtn').addEventListener('click', function() {
    console.log('Sign Up button clicked. Redirecting to registration page...');
    // window.location.href = '/register.jsp'; // Example redirect
});

document.getElementById('reportCrimeBtn').addEventListener('click', function() {
    console.log('Report a Crime button clicked. Redirecting to complaint form...');
    // window.location.href = '/civilian/new_complaint.jsp'; // Example redirect
});

document.getElementById('registerNowBtn').addEventListener('click', function() {
    console.log('Register Now button clicked. Redirecting to registration page...');
    // window.location.href = '/register.jsp'; // Example redirect
});

// Add a little scroll-based effect for the navbar
window.addEventListener('scroll', function() {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 50) {
        navbar.classList.add('shadow-sm');
    } else {
        navbar.classList.remove('shadow-sm');
    }
});