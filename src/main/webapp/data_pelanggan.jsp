<%@page import="omat.pbo.servis.mobil.model.Customer"%>
<%@page import="omat.pbo.servis.mobil.dao.CustomerDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // LOGIKA DATA
    List<Customer> listCustomer = (List<Customer>) request.getAttribute("listPelanggan");
    if(listCustomer == null) {
        CustomerDAO dao = new CustomerDAO();
        listCustomer = dao.getAllCustomers();
    }
    
    String alertStatus = (String) session.getAttribute("alertStatus");
    String alertMessage = (String) session.getAttribute("alertMessage");
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database Pelanggan</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="css/data_pelanggan.css" rel="stylesheet">

    
</head>
<body>

    <% if (alertStatus != null) { %>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            Swal.fire({
                icon: '<%= alertStatus %>',
                title: '<%= alertMessage %>',
                showConfirmButton: false, timer: 2000, toast: true, position: 'top-end'
            });
        </script>
        <% session.removeAttribute("alertStatus"); session.removeAttribute("alertMessage"); %>
    <% } %>

    <div class="page-header d-flex justify-content-between align-items-end">
        <div>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-2">
                    <li class="breadcrumb-item small"><a href="dashboard.jsp">Dashboard</a></li>
                    <li class="breadcrumb-item small active">Pelanggan</li>
                </ol>
            </nav>
            <h3 class="fw-bold m-0">Database Pelanggan</h3>
        </div>
        
        <button class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm" style="background: #4361ee; border: none;" onclick="openAddModal()">
            <i class="fas fa-plus me-2"></i> Pelanggan Baru
        </button>
    </div>

    <div class="data-card">
        <div class="filter-bar">
            <div>
                <h6 class="fw-bold m-0 text-dark">Daftar Member</h6>
                <span class="text-muted small">Total <span class="fw-bold"><%= (listCustomer != null) ? listCustomer.size() : 0 %></span> data tersimpan</span>
            </div>
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" class="form-input-custom" placeholder="Cari nama atau nomor WA...">
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-hover mb-0" id="customerTable">
                <thead>
                    <tr>
                        <th width="35%">Identitas Pelanggan</th>
                        <th width="25%">Kontak</th>
                        <th width="25%">Alamat Domisili</th>
                        <th width="15%" class="text-end">Opsi</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(listCustomer != null && !listCustomer.isEmpty()) { 
                        for(Customer c : listCustomer) { 
                            String initial = (c.getNama() != null && c.getNama().length() > 0) ? c.getNama().substring(0, 1).toUpperCase() : "?";
                    %>
                    <tr>
                        <td>
                            <div class="d-flex align-items-center">
                                <div class="avatar-circle"><%= initial %></div>
                                <div>
                                    <div class="fw-bold text-dark"><%= c.getNama() %></div>
                                    <div class="text-muted small" style="font-size: 11px;">ID: CUST-<%= c.getId() %></div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="wa-badge">
                                <i class="fab fa-whatsapp me-2"></i> <%= c.getWhatsapp() %>
                            </div>
                        </td>
                        <td class="text-secondary small">
                            <i class="fas fa-map-marker-alt me-1 text-muted"></i> <%= c.getAlamat() %>
                        </td>
                        <td class="text-end">
                            <div class="action-group">
                                <button class="btn-icon btn-edit" 
                                        onclick="openEditModal('<%=c.getId()%>','<%=c.getNama()%>','<%=c.getWhatsapp()%>','<%=c.getAlamat()%>')"
                                        data-bs-toggle="tooltip" title="Edit Data">
                                    <i class="fas fa-pen small"></i>
                                </button>
                                <button class="btn-icon btn-delete" 
                                        onclick="confirmDelete('<%=c.getId()%>')"
                                        data-bs-toggle="tooltip" title="Hapus Data">
                                    <i class="fas fa-trash-alt small"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                    <% }} else { %>
                    <tr>
                        <td colspan="4" class="text-center py-5">
                            <i class="fas fa-users-slash fa-3x mb-3 text-muted opacity-25"></i>
                            <p class="text-muted fw-bold">Belum ada data pelanggan.</p>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="modal fade" id="customerModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0 pb-0 pt-4 px-4">
                    <h5 class="fw-bold m-0" id="modalTitle">Form Pelanggan</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="CustomerServlet" method="POST">
                    <div class="modal-body p-4">
                        <input type="hidden" name="action" id="formAction">
                        <input type="hidden" name="id" id="customerId">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold small text-muted">NAMA LENGKAP</label>
                            <input type="text" name="nama" id="inputNama" class="form-control" placeholder="Masukan nama pelanggan" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold small text-muted">WHATSAPP / HP</label>
                            <input type="text" name="whatsapp" id="inputWhatsapp" class="form-control" placeholder="08xxxxxxxxxx" required>
                        </div>

                        <div class="mb-1">
                            <label class="form-label fw-bold small text-muted">ALAMAT LENGKAP</label>
                            <textarea name="alamat" id="inputAlamat" class="form-control" rows="3" placeholder="Alamat domisili..." required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-0 px-4 pb-4">
                        <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold" style="background: #4361ee; border: none;">Simpan Data</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <script>
        const modal = new bootstrap.Modal(document.getElementById('customerModal'));
        
        // Inisialisasi Tooltip Bootstrap (opsional, biar muncul tulisan saat hover)
        const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
        const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
        
        function openAddModal() {
            document.getElementById('modalTitle').innerText = "Tambah Pelanggan Baru";
            document.getElementById('formAction').value = 'add';
            document.getElementById('customerId').value = '';
            document.getElementById('inputNama').value = '';
            document.getElementById('inputWhatsapp').value = '';
            document.getElementById('inputAlamat').value = '';
            modal.show();
        }

        function openEditModal(id, n, w, a) {
            document.getElementById('modalTitle').innerText = "Edit Data Pelanggan";
            document.getElementById('formAction').value = 'update';
            document.getElementById('customerId').value = id;
            document.getElementById('inputNama').value = n;
            document.getElementById('inputWhatsapp').value = w;
            document.getElementById('inputAlamat').value = a;
            modal.show();
        }

        function confirmDelete(id) {
            Swal.fire({
                title: 'Hapus Data?',
                text: "Data pelanggan akan hilang permanen!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#ef4444',
                cancelButtonColor: '#64748b',
                confirmButtonText: 'Ya, Hapus!',
                cancelButtonText: 'Batal'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href='CustomerServlet?action=delete&id=' + id;
                }
            })
        }

        // Live Search
        document.getElementById('searchInput').addEventListener('keyup', function () {
            let filter = this.value.toLowerCase();
            let rows = document.querySelectorAll('#customerTable tbody tr');

            rows.forEach(row => {
                if(row.cells.length < 2) return;
                let text = row.innerText.toLowerCase();
                row.style.display = text.includes(filter) ? '' : 'none';
            });
        });
    </script>
</body>
</html>