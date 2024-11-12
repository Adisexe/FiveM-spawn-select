const form = document.querySelector('.container');

document.addEventListener('mousemove', (e) => {
    const x = (window.innerWidth / 2 - e.pageX) / 50;
    const y = (window.innerHeight / 2 - e.pageY) / 50;

    form.style.transform = `rotateY(${x}deg) rotateX(${y}deg)`;
});

window.addEventListener("message", (event) => {
    if (event.data.type === "enableSpawnMenu") {
        if (event.data.enable == true){
            if (event.data.firstSpawn == true){
                const lastPos = document.querySelector('#last-place');
                lastPos.classList.add('locked');
            }
            
            document.getElementsByTagName("BODY")[0].style.display = "flex";

        } else {
            document.getElementsByTagName("BODY")[0].style.display = "none";
        }
    }
});  