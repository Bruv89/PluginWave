document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("registerForm");

    form.addEventListener("submit", function (e) {
        let valid = true;
        clearErrors();

        const nome = form.nome.value.trim();
        const email = form.email.value.trim();
        const password = form.password.value.trim();

        if (nome === "") {
            showError("nome", "Il nome è obbligatorio");
            valid = false;
        }

        if (!email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
            showError("email", "Email non valida");
            valid = false;
        }

        if (password.length < 6) {
            showError("password", "La password deve avere almeno 6 caratteri");
            valid = false;
        }

        if (!valid) {
            e.preventDefault();
        }
    });

    function showError(fieldName, message) {
        const field = document.getElementsByName(fieldName)[0];
        const error = document.createElement("div");
        error.className = "error";
        error.textContent = message;
        field.parentNode.insertBefore(error, field.nextSibling);
    }

    function clearErrors() {
        document.querySelectorAll(".error").forEach(e => e.remove());
    }
});
