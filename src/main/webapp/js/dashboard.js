// Real-time Clock
function startTime() {
    const now = new Date();
    const options = {weekday: 'long', year: 'numeric', month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit', second: '2-digit'};
    document.getElementById('clock').innerHTML = '<i class="far fa-clock me-2 text-primary"></i>' + now.toLocaleDateString('id-ID', options);
    setTimeout(startTime, 1000);
}
startTime();

// Dynamic Price Calculator
const checks = document.querySelectorAll('.chk-admin');
const display = document.getElementById('totalAdminDisplay');

function calculateTotal() {
    let total = 0;
    checks.forEach(i => {
        if (i.checked) {
            total += parseInt(i.value.split('|')[1]);
        }
    });
    display.innerText = 'Rp ' + total.toLocaleString('id-ID');
}

// Add event listener to all checkboxes
checks.forEach(c => {
    c.addEventListener('change', calculateTotal);
});

// Status Update Action
function updateStatus(id, nextStatus) {
    Swal.fire({
        title: 'Update Status?',
        text: "Status akan diubah menjadi: " + nextStatus,
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#2563eb',
        cancelButtonColor: '#64748b',
        confirmButtonText: 'Ya, Update',
        cancelButtonText: 'Batal'
    }).then((result) => {
        if (result.isConfirmed) {
            // Redirect to Servlet to handle logic
            window.location.href = "BookingServlet?action=updateStatus&id=" + id + "&status=" + nextStatus;
        }
    });
}

// Delete Action
function confirmDelete(id) {
    Swal.fire({
        title: 'Hapus Data?',
        text: "Data Booking ID #" + id + " akan dihapus permanen!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc2626',
        cancelButtonColor: '#64748b',
        confirmButtonText: 'Ya, Hapus',
        cancelButtonText: 'Batal'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = "BookingServlet?action=delete&id=" + id;
        }
    });
}

// Logout Action
function logout() {
    Swal.fire({
        title: 'Keluar Sistem?',
        text: "Anda harus login kembali untuk mengakses dashboard.",
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#dc2626',
        cancelButtonColor: '#64748b',
        confirmButtonText: 'Ya, Keluar'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = "LoginServlet?action=logout";
        }
    });
}

// Form Submission (Add Offline Booking)
document.getElementById('formTambahAdmin').onsubmit = function (e) {
    e.preventDefault();

    // Check if at least one service is selected
    let serviceSelected = false;
    checks.forEach(c => {
        if (c.checked)
            serviceSelected = true;
    });

    if (!serviceSelected) {
        Swal.fire('Error', 'Pilih minimal satu layanan servis!', 'error');
        return;
    }

    Swal.fire({
        title: 'Menyimpan...',
        text: 'Mohon tunggu sebentar',
        didOpen: () => {
            Swal.showLoading()
        }
    });

    // Send data to Servlet via Fetch API
    fetch('BookingServlet', {
        method: 'POST',
        body: new URLSearchParams(new FormData(this))
    })
            .then(response => {
                if (response.ok) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Berhasil!',
                        text: 'Data transaksi berhasil disimpan.',
                        timer: 1500,
                        showConfirmButton: false
                    }).then(() => {
                        location.reload(); // Reload page to show new data
                    });
                } else {
                    Swal.fire('Gagal', 'Terjadi kesalahan pada server.', 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                Swal.fire('Error', 'Gagal menghubungi server.', 'error');
            });
};