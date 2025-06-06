document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("checkoutForm");

    form.addEventListener("submit", function (e) {
        clearErrors();
        let valid = true;

        const indirizzo = form.indirizzo.value.trim();
        const citta = form.citta.value.trim();
        const cap = form.cap.value.trim();
        const carta = form.carta.value.trim();
        const intestatario = form.intestatario.value.trim();

        if (indirizzo === "") {
            showError(form.indirizzo, "Inserisci un indirizzo.");
            valid = false;
        }

        if (citta === "") {
            showError(form.citta, "Inserisci una città.");
            valid = false;
        }

        if (!/^\d{5}$/.test(cap)) {
            showError(form.cap, "Il CAP deve essere di 5 cifre.");
            valid = false;
        }

        if (!/^\d{16}$/.test(carta)) {
            showError(form.carta, "Numero carta non valido (16 cifre).");
            valid = false;
        }

        if (intestatario === "") {
            showError(form.intestatario, "Inserisci il nome dell'intestatario.");
            valid = false;
        }

        if (!valid) {
            e.preventDefault();
        }
    });

    function showError(input, message) {
        const error = document.createElement("div");
        error.className = "error";
        error.textContent = message;
        input.parentNode.insertBefore(error, input.nextSibling);
    }

    function clearErrors() {
        document.querySelectorAll(".error").forEach(e => e.remove());
    }
});
