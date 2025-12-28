<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Insurance Agent - Login/Register page</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<link rel='stylesheet'
	href='https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css'>
<link rel='stylesheet'
	href='https://pro.fontawesome.com/releases/v5.10.2/css/all.css'>
<style>
	/* Base Styles */
	body {
		font-family: 'Poppins', sans-serif;
		margin: 0;
		padding: 0;
		background: var(--background);
		color: var(--text1);
		transition: background 0.5s ease;
		min-height: 100vh;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		/* Added to prevent scroll from animations */
		overflow: hidden; 
	}

	body.light-theme {
		background: #fcfbfe;
	}
	

	/* Theme Variables */
	:root {
		/* Updated background for better blend with new theme */
		--background: #050505; 
		--color: #F5F7FA;
		--sectionBackground: #222126;
		--borderColor: #252429;
		--text1: #F5F7FA;
		--text2: #E6E9ED;
		--shadow: rgba(0,0,0,0.1);
		--iconColor: #05c534;
		--roleButtonBg: #3a3a3a;
		--roleButtonActiveBg: #05c534;
		--roleButtonText: #F5F7FA;
		--card-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
	}

	.light-theme {
		--background: #fcfbfe;
		--color: #323133;
		--sectionBackground: #ffffff;
		--borderColor: #e9e9e9;
		--text1: #323133;
		--text2: #3C3B3D;
		--iconColor: #0fce3d;
		--roleButtonBg: #e9e9e9;
		--roleButtonActiveBg: #0fce3d;
		--roleButtonText: #323133;
		--card-shadow: 0 10px 25px rgba(0, 0, 0, 0.1), 0 5px 10px rgba(0, 0, 0, 0.04);
	}

	/* --- NEW: App Header Styles --- */
	.app-header {
		position: relative;
		z-index: 15;
		text-align: center;
		margin-bottom: 2rem;
		animation: slideInFromTop 1s ease-out;
		transition: margin-top 0.8s cubic-bezier(0.4, 0.2, 0.2, 1);
	}
	
	/* Add margin-top when card is flipped */
	.flip-card.flipped ~ .app-header,
	.container:has(.flip-card.flipped) .app-header {
		margin-top: 2rem;
	}

	.app-logo {
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 0.75rem;
		margin-bottom: 0.5rem;
	}

	.logo-icon {
		width: 45px;
		height: 45px;
		background: linear-gradient(135deg, var(--iconColor), #0a8f3a);
		border-radius: 12px;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 20px;
		color: white;
		box-shadow: 0 4px 15px rgba(5, 197, 52, 0.3);
		animation: pulse 2s ease-in-out infinite;
	}

	.app-title {
		font-size: 2.2rem;
		font-weight: 700;
		color: var(--text1);
		margin: 0;
		text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
		background: linear-gradient(135deg, var(--text1), var(--iconColor));
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
	}

	.app-subtitle {
		font-size: 0.95rem;
		color: var(--text2);
		margin: 0;
		opacity: 0.8;
		font-weight: 300;
		letter-spacing: 1px;
	}

	/* Light theme adjustments */
	.light-theme .app-title {
		background: linear-gradient(135deg, var(--text1), var(--iconColor));
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
	}

	.light-theme .logo-icon {
		box-shadow: 0 4px 15px rgba(15, 206, 61, 0.2);
	}

	@keyframes slideInFromTop {
		0% {
			opacity: 0;
			transform: translateY(-30px);
		}
		100% {
			opacity: 1;
			transform: translateY(0);
		}
	}

	@keyframes pulse {
		0%, 100% {
			transform: scale(1);
		}
		50% {
			transform: scale(1.05);
		}
	}

	/* --- NEW: Animated Background Styles --- */
	.gradient-background {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		z-index: 1;
		overflow: hidden;
	}
	
	/* Hide background on light theme */
	.light-theme .gradient-background {
		display: none;
	}

	.gradient-sphere {
		position: absolute;
		border-radius: 50%;
		filter: blur(80px);
		opacity: 0.7;
	}

	.sphere-1 {
		width: 40vw;
		height: 40vw;
		background: linear-gradient(40deg, rgba(255, 0, 128, 0.6), rgba(98, 216, 249, 0.4));
		top: -10%;
		left: -10%;
		animation: float-1 15s ease-in-out infinite alternate;
	}

	.sphere-2 {
		width: 45vw;
		height: 45vw;
		background: linear-gradient(240deg, rgba(72, 0, 255, 0.6), rgba(0, 183, 255, 0.4));
		bottom: -20%;
		right: -10%;
		animation: float-2 18s ease-in-out infinite alternate;
	}
	
	.noise-overlay {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		opacity: 0.04;
		z-index: 5;
		background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)'/%3E%3C/svg%3E");
	}

	.particles-container {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		z-index: 3;
		pointer-events: none;
	}

	.particle {
		position: absolute;
		background: white;
		border-radius: 50%;
		opacity: 0;
		pointer-events: none;
	}

	@keyframes float-1 {
		0% { transform: translate(0, 0) scale(1); }
		100% { transform: translate(10%, 10%) scale(1.1); }
	}

	@keyframes float-2 {
		0% { transform: translate(0, 0) scale(1); }
		100% { transform: translate(-10%, -5%) scale(1.15); }
	}

	/* --- End of New Background Styles --- */
	
	.container {
		position: relative;
		z-index: 10; /* Ensure content is above the background */
		display: flex;
		flex-direction: column;
		align-items: center;
	}

	/* Dark Mode Toggle */
	.darkmode {
		position: fixed;
		bottom: 1rem;
		left: 1rem;
		font-size: 1.75rem;
		padding: 1rem;
		border-radius: 100%;
		border: 1px solid var(--iconColor);
		box-shadow: 0 0 1rem -0.25rem var(--iconColor), inset 0 0 1rem -0.75rem var(--iconColor);
		color: var(--iconColor);
		cursor: pointer;
		transition: all 0.25s;
		background: var(--sectionBackground);
		z-index: 100;
	}

	.darkmode:hover {
		box-shadow: 0 0 1rem -0.25rem var(--iconColor), inset 0 0 1rem -0.25rem var(--iconColor);
	}

	/* Flip Card Container */
	.flip-card {
		width: 420px;
		min-height: 480px;
		position: relative;
		transform-style: preserve-3d;
		transition: transform 0.8s cubic-bezier(0.4, 0.2, 0.2, 1);
		border-radius: 10px;
	}

	.flip-card.flipped {
		transform: rotateY(180deg);
		min-height: 800px;
		width: 460px;
	}

	/* Front and Back Faces */
	.flip-card-front, .flip-card-back {
		position: absolute;
		width: 100%;
		height: 100%;
		backface-visibility: hidden;
		padding: 30px 40px;
		box-sizing: border-box;
		background: rgba(34, 33, 38, .5); /* Darker semi-transparent bg */
		backdrop-filter: blur(10px); /* Glass effect */
		-webkit-backdrop-filter: blur(10px);
		box-shadow: var(--card-shadow);
		border-radius: 15px;
		border: 1px solid rgba(255, 255, 255, 0.1);
		transition: background 0.5s ease, box-shadow 0.5s ease;
		
		
		
		display: flex;
		flex-direction: column;
		justify-content: center;
	}

	.light-theme .flip-card-front, 
	.light-theme .flip-card-back {
		background: rgba(255,255,255,.8);
		backdrop-filter: blur(10px);
		-webkit-backdrop-filter: blur(10px);
		border: 1px solid rgba(255, 255, 255, 0.2);
	}

	.flip-card-back {
		transform: rotateY(180deg);
		height: 88%;
	}

	/* Common Form Styles */
	.flip-card h2 {
		margin: 0 0 30px;
		padding: 0;
		color: var(--text1);
		text-align: center;
	}

	.user-box {
		position: relative;
		margin-bottom: 25px;
	}

	.user-box input {
		width: 100%;
		padding: 10px 0;
		font-size: 16px;
		color: var(--text1);
		border: none;
		border-bottom: 1px solid var(--text1);
		outline: none;
		background: transparent;
	}

	.user-box label {
		position: absolute;
		top: 0;
		left: 0;
		padding: 10px 0;
		font-size: 16px;
		color: var(--text1);
		pointer-events: none;
		transition: .5s;
	}

	.user-box input:focus ~ label,
	.user-box input:valid ~ label {
		top: -20px;
		left: 0;
		color: var(--iconColor);
		font-size: 12px;
	}

	/* Role Selection Buttons */
	.role-selection {
		display: flex;
		justify-content: space-between;
		margin-bottom: 30px;
		gap: 10px;
		margin-top: 60px; 
	}

	.role-button {
		flex: 1;
		padding: 8px 0;
		border: none;
		border-radius: 20px;
		background: var(--roleButtonBg);
		color: var(--roleButtonText);
		font-size: 14px;
		cursor: pointer;
		transition: all 0.3s ease;
	}

	.role-button.active {
		background: var(--roleButtonActiveBg);
		color: white;
		font-weight: bold;
		box-shadow: 0 0 10px rgba(5, 197, 52, 0.5);
	}

	/* Submit Button Styles */
	.submit-btn {
		position: relative;
		display: inline-block;
		padding: 10px 20px;
		color: var(--iconColor);
		font-size: 16px;
		text-decoration: none;
		text-transform: uppercase;
		overflow: hidden;
		transition: .5s;
		margin: 20px 0 15px;
		letter-spacing: 4px;
		background: transparent;
		border: none;
		cursor: pointer;
	}

	.submit-btn:hover {
		background: var(--iconColor);
		color: #fff;
		border-radius: 5px;
		box-shadow: 0 0 5px var(--iconColor),
					0 0 25px var(--iconColor),
					0 0 50px var(--iconColor),
					0 0 100px var(--iconColor);
	}

	/* Button Animation */
	.submit-btn span {
		position: absolute;
		display: block;
	}

	.submit-btn span:nth-child(1) {
		top: 0; left: -100%; width: 100%; height: 2px;
		background: linear-gradient(90deg, transparent, var(--iconColor));
		animation: btn-anim1 1s linear infinite;
	}

	.submit-btn span:nth-child(2) {
		top: -100%; right: 0; width: 2px; height: 100%;
		background: linear-gradient(180deg, transparent, var(--iconColor));
		animation: btn-anim2 1s linear infinite;
		animation-delay: .25s
	}

	.submit-btn span:nth-child(3) {
		bottom: 0; right: -100%; width: 100%; height: 2px;
		background: linear-gradient(270deg, transparent, var(--iconColor));
		animation: btn-anim3 1s linear infinite;
		animation-delay: .5s
	}

	.submit-btn span:nth-child(4) {
		bottom: -100%; left: 0; width: 2px; height: 100%;
		background: linear-gradient(360deg, transparent, var(--iconColor));
		animation: btn-anim4 1s linear infinite;
		animation-delay: .75s
	}

	/* Toggle Link */
	.toggle-form {
		display: block;
		text-align: center;
		margin-top: 20px;
		color: var(--text1);
		cursor: pointer;
		transition: color 0.3s;
		font-size: 14px;
		font-weight: 100;
	}

	.toggle-form:hover {
		color: var(--iconColor);
		text-decoration: underline;
	}

	/* Keyframe Animations */
	@keyframes btn-anim1 { 0% { left: -100%; } 50%,100% { left: 100%; } }
	@keyframes btn-anim2 { 0% { top: -100%; } 50%,100% { top: 100%; } }
	@keyframes btn-anim3 { 0% { right: -100%; } 50%,100% { right: 100%; } }
	@keyframes btn-anim4 { 0% { bottom: -100%; } 50%,100% { bottom: 100%; } }
	
	/* Autofill Style Override */
	input:-webkit-autofill,
	input:-webkit-autofill:hover, 
	input:-webkit-autofill:focus, 
	input:-webkit-autofill:active {
		-webkit-text-fill-color: var(--text1) !important;
		background-color: transparent !important;
		transition: background-color 5000s ease-in-out 0s;
	}

	/* Other styles for date picker, register role button, etc. remain the same */
	.user-box input[type="date"]{color:var(--text1);background-color:transparent;font-family:'Poppins',sans-serif;padding-top:10px;height:40px}.user-box input[type="date"]:not(:focus):not(:valid)::-webkit-datetime-edit{color:transparent}.user-box input[type="date"]:focus ~ label,.user-box input[type="date"]:valid ~ label{top:-20px;left:0;color:var(--iconColor);font-size:12px}.register-role-selection{display:flex;justify-content:space-between;gap:10px;margin:25px 0}.register-role-button{flex:1;padding:10px;border-radius:20px;border:none;background:var(--roleButtonBg);color:var(--roleButtonText);cursor:pointer;font-size:14px;transition:background .3s}.register-role-button.active{background:var(--roleButtonActiveBg);color:white;font-weight:bold;box-shadow:0 0 10px rgba(5,197,52,.5)}
</style>
</head>
<body>
	<div class="gradient-background">
        <div class="gradient-sphere sphere-1"></div>
        <div class="gradient-sphere sphere-2"></div>
        <div class="noise-overlay"></div>
        <div class="particles-container" id="particles-container"></div>
    </div>
	
	<div class="container">
		<!-- NEW: App Header -->
		<div class="app-header">
			<div class="app-logo">
				<div class="logo-icon">
					<i class="fas fa-shield-alt"></i>
				</div>
				<h1 class="app-title">My Insurance Agent</h1>
			</div>
			<p class="app-subtitle">Secure | Reliable | Trusted</p>
		</div>

		<button class="darkmode fas fa-moon"></button>

		<div class="flip-card" id="flipCard">
			<div class="flip-card-front">
				<h2>Login</h2>
				<form id="loginForm" action="loginUser" method="POST">
					<div class="user-box">
						<input type="text" name="email" required> <label>Email</label>
					</div>
					<div class="user-box">
						<input type="password" name="password" required> <label>Password</label>
					</div>
					<div class="user-box">
						<div class="role-selection">
							<button type="button" class="role-button active"
								data-role="policyHolder">Policy Holder</button>
							<button type="button" class="role-button"
								data-role="insuranceAgent">Insurance Agent</button>
							<button type="button" class="role-button" data-role="admin">Admin</button>
						</div>
						<input type="hidden" name="role" value="policyHolder"
							id="roleInput">
					</div>

					<button type="submit" class="submit-btn">
						<span></span><span></span><span></span><span></span> Login
					</button>
					<a class="toggle-form" id="showRegister">Don't have an account?
						Please sign up</a>
				</form>
			</div>

			<div class="flip-card-back">
				<h2>Register</h2>
				<form id="registerForm" action="registerAgent" method="POST">
					<div class="user-box">
						<input type="text" name="fullname" required> <label>Full
							Name</label>
					</div>
					<div class="user-box">
						<input type="email" name="email" required> <label>Email</label>
					</div>
					<div class="user-box">
						<input type="date" name="dob" required placeholder=" "> <label>Date
							of Birth</label>
					</div>
					<div class="user-box">
						<input type="tel" name="contact" required> <label>Contact
							Number</label>
					</div>
					<div class="user-box">
						<input type="text" name="address" required> <label>Address</label>
					</div>
					<div class="user-box">
						<input type="password" name="password" required> <label>Password</label>
					</div>
					
					<button type="submit" class="submit-btn">
						<span></span><span></span><span></span><span></span> Register
					</button>
					<a class="toggle-form" id="showLogin">Already have an account?
						Sign in</a>
				</form>
			</div>
		</div>
	</div>

	<script
		src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js'></script>
	<script>
		// Original jQuery functions for theme toggle and form logic
		$(document).ready(function() {
			$('.darkmode').click(function() {
				$('body').toggleClass('light-theme');
				$(this).toggleClass('fa-moon fa-sun');
			});

			$('.role-button').click(function() {
				$('.role-button').removeClass('active');
				$(this).addClass('active');
				$('#roleInput').val($(this).data('role'));
			});

			$('.register-role-button').click(function() {
				$('.register-role-button').removeClass('active');
				$(this).addClass('active');
				$('#registerRoleInput').val($(this).data('register-role'));
			});

			$('#showRegister').click(function(e) {
				e.preventDefault();
				$('#flipCard').addClass('flipped');
			});

			$('#showLogin').click(function(e) {
				e.preventDefault();
				$('#flipCard').removeClass('flipped');
			});

			$('#loginForm').submit(function(e) {
				// Optional JS validation can go here
			});

			$('#registerForm').submit(function(e) {
				// Optional JS validation can go here
			});
		});

		var particlesContainer = document.getElementById('particles-container');
		if (particlesContainer) {
		    var particleCount = 50;

		    function createParticle() {
		        var particle = document.createElement('div');
		        particle.className = 'particle';
		        var size = Math.random() * 2 + 1;
		        particle.style.width = size + 'px'; // Replaced template literal
		        particle.style.height = size + 'px'; // Replaced template literal
		        resetParticle(particle);
		        particlesContainer.appendChild(particle);
		        animateParticle(particle);
		    }

		    function resetParticle(particle) {
		        var posX = Math.random() * 100;
		        var posY = Math.random() * 100;
		        particle.style.left = posX + '%'; // Replaced template literal
		        particle.style.top = posY + '%'; // Replaced template literal
		        particle.style.opacity = '0';
		        return { x: posX, y: posY };
		    }

		    function animateParticle(particle) {
		        var pos = resetParticle(particle);
		        var duration = Math.random() * 10 + 10;
		        var delay = Math.random() * 5;

		        setTimeout(function() { // Replaced arrow function
		            particle.style.transition = 'all ' + duration + 's linear'; // Replaced template literal
		            particle.style.opacity = Math.random() * 0.4 + 0.1;
		            var moveX = pos.x + (Math.random() * 20 - 10);
		            var moveY = pos.y - Math.random() * 30; // Move upwards
		            particle.style.left = moveX + '%'; // Replaced template literal
		            particle.style.top = moveY + '%'; // Replaced template literal
		            setTimeout(function() { // Replaced arrow function
		                animateParticle(particle);
		            }, duration * 1000);
		        }, delay * 1000);
		    }

		    for (var i = 0; i < particleCount; i++) {
		        createParticle();
		    }

		    document.addEventListener('mousemove', function(e) { // Replaced arrow function
		        // Subtle movement of gradient spheres
		        var spheres = document.querySelectorAll('.gradient-sphere');
		        var moveX = (e.clientX / window.innerWidth - 0.5) * 20;
		        var moveY = (e.clientY / window.innerHeight - 0.5) * 20;

		        spheres.forEach(function(sphere) { // Replaced arrow function
		            sphere.style.transform = 'translate(' + moveX + 'px, ' + moveY + 'px)'; // Replaced template literal
		        });
		    });
		}
	</script>
</body>
</html>