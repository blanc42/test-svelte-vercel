<script>
    import { gsap } from "gsap";
    import { ScrollTrigger } from "gsap/ScrollTrigger";
    import { onMount } from "svelte";

    gsap.registerPlugin(ScrollTrigger);

    let showModal = false;

	function scrollToTop() {
		window.scrollTo({ top: 0, behavior: 'smooth' });
	}

    onMount(() => {
        // Hero text animation
        const heroLines = gsap.utils.toArray('.hero-line');
        heroLines.forEach((line, i) => {
            gsap.from(line, {
                y: 100,
                opacity: 0,
                duration: 1,
                delay: i * 0.2,
                ease: "power4.out"
            });
        });

        // Orange overlay and image grid animation
        const gridTimeline = gsap.timeline({
            scrollTrigger: {
                trigger: ".image-grid",
                start: "top top",
                end: "+=300%",
                scrub: 1,
                pin: true,
                anticipatePin: 1,
            }
        });

        // Calculate the scale needed to make center image fill the screen
        const calculateScale = () => {
            const centerImage = document.querySelector('.image-center-middle');
            if (!centerImage) return 2.6; // fallback value
            
            const viewportWidth = window.innerWidth;
            const imageWidth = centerImage.getBoundingClientRect().width - 80;
            return viewportWidth / imageWidth;
        };

        gridTimeline
            // Zoom into the entire grid until center image fills screen
            .to(".grid-container", {
                scale: calculateScale(),
                duration: 3,
                ease: "none"
            })
            // Fade in text after zoom completes
            .from(".overlay-text", {
                opacity: 0,
                y: 30,
                duration: 1,
                ease: "power2.out"
            }, "-=0.5");

        // Recalculate scale on window resize
        window.addEventListener('resize', () => {
            gridTimeline.invalidate();
        });

        // Updated contact section animations
        gsap.from(".contact-title span", {
            scrollTrigger: {
                trigger: ".contact",
                start: "top 80%",
                toggleActions: "play none none none"
            },
            y: 100,
            opacity: 0,
            duration: 1.2,
            stagger: 0.2,
            ease: "elastic.out(1, 0.8)"
        });

        gsap.from(".contact-info-item", {
            scrollTrigger: {
                trigger: ".contact-info",
                start: "top 85%",
                toggleActions: "play none none none"
            },
            scale: 0.8,
            y: 60,
            duration: 0.8,
            stagger: 0.15,
            ease: "back.out(1.7)"
        });
    });

    function toggleModal() {
        showModal = !showModal;
    }
</script>

<main>
    <section class="hero max-w-screen-2xl mx-auto">
        <div class="hero-text">
            <p class="overline2 hero-line">NEXT-GEN DIGITAL SIGNAGE</p>
            <h1>
                <span class="hero-line white">TRANSFORM</span>
                <span class="hero-line white">ANY</span>
                <span class="hero-line white">ANDROID TV</span>
            </h1>
            <p class="subtitle hero-line">Powerful digital signage solution that works seamlessly with all Android TVs. 
                Deploy content across multiple displays instantly.</p>
            <div class="cta-group hero-line">
                <button class="cta-primary">Contact Us</button>
                <button class="cta-secondary" on:click={toggleModal}>Watch Demo</button>
            </div>
            <div class="tech-stack hero-line">
                <span>Compatible with</span>
                <div class="tech-icons">
					<span class="flex items-center gap-2">
						<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-tv"><rect width="20" height="15" x="2" y="7" rx="2" ry="2"/><polyline points="17 2 12 7 7 2"/></svg>
						<span>Android TV</span>
					</span>
                    <span class="flex items-center gap-2">
						<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-cast"><path d="M2 8V6a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2h-6"/><path d="M2 12a9 9 0 0 1 8 8"/><path d="M2 16a5 5 0 0 1 4 4"/><line x1="2" x2="2.01" y1="20" y2="20"/></svg>
						<span>Chromecast</span>
					</span>
                </div>
            </div>
        </div>
    </section>

    <section class="image-grid">
        <div class="grid-container">
            <!-- Left column -->
            <img src="https://picsum.photos/seed/1/800/600" alt="Nature 1" class="image image-left-top" />
            <img src="https://picsum.photos/seed/2/800/800" alt="Nature 2" class="image image-left-bottom" />

            <!-- Center column -->
            <img src="https://picsum.photos/seed/3/1200/400" alt="Nature 3" class="image image-center-top" />
            <img src="https://picsum.photos/seed/givemesomething/1200/800" alt="Nature 4" class="image image-center-middle" />
            <img src="https://picsum.photos/seed/5/1200/400" alt="Nature 5" class="image image-center-bottom" />

            <!-- Right column -->
            <img src="https://picsum.photos/seed/6/800/600" alt="Nature 6" class="image image-right-top" />
            <img src="https://picsum.photos/seed/7/800/600" alt="Nature 7" class="image image-right-bottom" />
        </div>

        <div class="overlay-text">
            <h2>Transform Your Space</h2>
            <p>Create immersive digital experiences that captivate your audience</p>
        </div>
    </section>

    <section class="contact">
        <div class="contact-container">
            <div class="contact-text">
                <h2 class="contact-title">
                    <span class="contact-title-line">Let's talk about</span>
                    <span class="contact-title-line">your next <span class="highlight">project</span> 🚀</span>
                </h2>
                <p class="contact-subtitle">We're just one click away from making something awesome together!</p>
            </div>
            <div class="contact-info">
                <div class="contact-info-item">
                    <div class="info-icon-wrapper">
                        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="20" height="16" x="2" y="4" rx="2"/><path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"/></svg>
                    </div>
                    <div class="info-content">
                        <div class="info-label">Drop us a line</div>
                        <a href="insightthinkersagency@gmail.com" class="info-value">
                            insightthinkersagency@gmail.com
                            <span class="emoji">✨</span>
                        </a>
                    </div>
                </div>
                <div class="contact-info-item">
                    <div class="info-icon-wrapper">
                        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
                    </div>
                    <div class="info-content">
                        <div class="info-label">Give us a ring</div>
                        <a href="tel:+91 6301721660" class="info-value">
                            +91 6301721660
                            <span class="emoji">📞</span>
                        </a>
                    </div>
                </div>
            </div>
            <div class="contact-cta">
                <p class="availability">Available worldwide 🌎</p>
                <button class="scroll-top" on:click={scrollToTop}>
                    Back to Top ↑
                </button>
            </div>
        </div>
    </section>
</main>

{#if showModal}
    <div 
        class="modal-overlay" 
        on:click={toggleModal}
        on:keydown={e => e.key === 'Escape' && toggleModal()}
        role="button"
        tabindex="0"
    >
        <div 
            class="modal-content" 
            on:click|stopPropagation
        >
            <button class="close-button" on:click={toggleModal}>×</button>
            <iframe
                src="/demo.mp4" 
                width="100%" 
                height="100%" 
                frameborder="0" 
                allow="autoplay; fullscreen; picture-in-picture" 
                allowfullscreen
            ></iframe>
        </div>
    </div>
{/if}

<style>
    main {
        background-color: #0F0F0F;
        color: #ffffff;
        overflow-x: hidden;
    }

    .hero {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 2rem;
        max-width: 100vw;
        overflow: hidden;
    }

    .hero-text {
        max-width: min(1200px, 90vw);
        margin: 0 auto;
    }

    .overline2 {
        font-size: 1rem;
        letter-spacing: 0.2em;
        color: #FF4500;
        margin-bottom: 2rem;
    }

    .hero-line {
        display: block;
        font-size: clamp(3rem, 12vw, 8rem);
        line-height: 0.9;
        font-weight: 900;
        margin: 0;
        letter-spacing: -0.02em;
        position: relative;
    }

    .strike {
        color: #FF4500;
        position: relative;
    }

    .strike::after {
        content: '';
        position: absolute;
        left: 0;
        right: 0;
        top: 50%;
        height: 3px;
        background: #FF4500;
        transform: translateY(-50%);
    }

    .white {
        color: #ffffff;
    }

    .subtitle {
        font-size: clamp(1.125rem, 2vw, 1.5rem);
        line-height: 1.5;
        margin-top: 2rem;
        margin-bottom: 3rem;
        max-width: 600px;
        opacity: 0.8;
    }

    .cta-group {
        display: flex;
        gap: 1rem;
        margin-bottom: 4rem;
    }

    .cta-primary, .cta-secondary {
        padding: 1rem 2rem;
        font-size: 1.125rem;
        border-radius: 0.5rem;
        font-weight: 600;
        cursor: pointer;
        transition: transform 0.2s ease;
		letter-spacing: 0.005em;
    }

    .cta-primary {
        background: #FF4500;
        color: white;
        border: none;
    }

    .cta-secondary {
        background: transparent;
        color: white;
        border: 2px solid rgba(255, 255, 255, 0.2);
    }

    .cta-primary:hover, .cta-secondary:hover {
        transform: translateY(-2px);
    }

    .tech-stack {
        font-size: 1rem;
        opacity: 0.6;
    }

    .tech-icons {
        display: flex;
        gap: 2rem;
        margin-top: 1rem;
    }

    .tech-icons img {
        height: 2rem;
        opacity: 0.8;
    }

    .image-grid {
        min-height: 100vh;
        width: 100%;
        background: #000;
        overflow: hidden;
        position: relative;
    }

    .grid-container {
        width: 100%;
        height: 100vh;
        display: grid;
        grid-template-columns: 30% 40% 30%;
        grid-template-rows: repeat(8, 1fr);
        gap: 2rem;
        padding: 2rem;
        transform-origin: center center;
    }

    .grid-container img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    /* Left column */
    .image-left-top {
        grid-column: 1;
        grid-row: 1 / span 4;
    }

    .image-left-bottom {
        grid-column: 1;
        grid-row: 5 / span 4;
    }

    /* Center column */
    .image-center-top {
        grid-column: 2;
        grid-row: 1 / span 2;
    }

    .image-center-middle {
        grid-column: 2;
        grid-row: 3 / span 4;
    }

    .image-center-bottom {
        grid-column: 2;
        grid-row: 7 / span 2;
    }

    /* Right column */
    .image-right-top {
        grid-column: 3;
        grid-row: 1 / span 4;
    }

    .image-right-bottom {
        grid-column: 3;
        grid-row: 5 / span 4;
    }

    @media (max-width: 768px) {
        .hero {
            padding: 2rem 1rem;
        }

        .hero-line {
            font-size: clamp(2rem, 8vw, 4rem);
        }

        .cta-group {
            flex-direction: column;
        }

        .grid-container {
            gap: 0.5rem;
            padding: 1rem;
        }
    }

    .modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.8);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 1000;
    }

    .modal-content {
        position: relative;
        width: 90%;
        height: 90%;
        max-width: 1200px;
        max-height: 800px;
        background: #000;
        border-radius: 0.5rem;
    }

    .close-button {
        position: absolute;
        top: -40px;
        right: 0;
        background: none;
        border: none;
        color: white;
        font-size: 2rem;
        cursor: pointer;
        padding: 0.5rem;
        line-height: 1;
    }

    .contact {
        min-height: 100vh;
		max-height: 100vh;
        background: linear-gradient(180deg, #0F0F0F 0%, #1A1A1A 100%);
        padding: 8rem 2rem;
        display: flex;
        align-items: center;
    }

    .contact-container {
        max-width: min(1200px, 90vw);
        margin: 0 auto;
        display: flex;
        flex-direction: column;
        gap: 6rem;
    }

    .contact-title {
        font-size: clamp(2.5rem, 8vw, 5rem);
        font-weight: 900;
        line-height: 1.1;
        margin-bottom: 1.5rem;
    }

    .contact-title-line {
        display: block;
    }

    .highlight {
        color: #FF4500;
        position: relative;
        display: inline-block;
    }

    .contact-subtitle {
        font-size: clamp(1.125rem, 2vw, 1.25rem);
        color: rgba(255, 255, 255, 0.8);
        max-width: 600px;
    }

    .contact-info {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
        gap: 2rem;
    }

    .contact-info-item {
        background: rgba(255, 255, 255, 0.03);
        border-radius: 24px;
        padding: 2rem;
        display: flex;
        gap: 1.5rem;
        transition: all 0.3s ease;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .contact-info-item:hover {
        background: rgba(255, 69, 0, 0.1);
        transform: translateY(-5px);
        border-color: rgba(255, 69, 0, 0.3);
    }

    .info-icon-wrapper {
        background: #FF4500;
        width: 64px;
        height: 64px;
        border-radius: 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
    }

    .info-content {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .info-label {
        font-size: 1rem;
        color: rgba(252, 252, 252, 0.6);
        text-transform: uppercase;
        letter-spacing: 0.1em;
    }

    .info-value {
        font-size: clamp(1.25rem, 2vw, 1.5rem);
        font-weight: 600;
        color: #ffffff;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        transition: all 0.3s ease;
    }

    .emoji {
        font-size: 1.2em;
        transition: transform 0.3s ease;
    }

    .contact-info-item:hover .emoji {
        transform: scale(1.2) rotate(10deg);
    }

    .contact-cta {
        text-align: center;
        margin-top: 2rem;
    }

    .availability {
        font-size: 1.125rem;
        color: rgba(255, 255, 255, 0.8);
        margin-bottom: 1rem;
    }

    .scroll-top {
        background: none;
        border: none;
        color: #FF4500;
        font-size: 1rem;
        cursor: pointer;
        padding: 0.5rem 1rem;
        border-radius: 20px;
        transition: all 0.3s ease;
    }

    .scroll-top:hover {
        background: rgba(255, 69, 0, 0.1);
        transform: translateY(-2px);
    }

    @media (max-width: 768px) {
        .contact {
            padding: 6rem 1rem;
        }

        .contact-container {
            gap: 4rem;
        }

        .contact-info-item {
            padding: 1.5rem;
        }
    }

    .overlay-text {
        position: fixed;
        left: 5rem;
        top: 50%;
        transform: translateY(-50%);
        color: #1b1b1b;
        /* color: #FF4500; */
        z-index: 3;
        max-width: 40%;
		font-family: 'Space Grotesk', sans-serif;
    }

    .overlay-text h2 {
        font-size: clamp(2rem, 5vw, 8rem);
        font-weight: 700;
        margin-bottom: 1rem;
        line-height: 1.1;
    }

    .overlay-text p {
        font-size: clamp(1rem, 1.5vw, 1.25rem);
        opacity: 0.8;
        line-height: 1.6;
    }

	.image {
		transform-origin: center center;
		z-index: 2;
		border-radius: 24px;
	}
</style>