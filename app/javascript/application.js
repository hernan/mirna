// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


Turbo.setConfirmMethod((message, element) => {
    let dialog = document.getElementById('turbo-confirm');
    dialog.querySelector('.dialog-message').textContent = message;
    dialog.showModal();

    return new Promise((resolve, _reject) => {
        dialog.addEventListener('close', (_event) => {
            resolve(dialog.returnValue === 'confirm');
        }, { once: true });
    });
});
