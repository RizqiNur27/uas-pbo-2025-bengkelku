<%@page import="omat.pbo.servis.mobil.dao.ServiceDAO"%>
<%@page import="omat.pbo.servis.mobil.model.Service"%>
<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // LOGIKA DATA (MVC Pattern)
    ServiceDAO serviceDao = new ServiceDAO();
    
    // Utamakan ambil dari request (dari Servlet), fallback ke DAO jika null (akses langsung JSP)
    List<Service> listService = (List<Service>) request.getAttribute("listService");
    if (listService == null) {
        listService = serviceDao.getAllServices();
    }
    
    // Format Mata Uang Rupiah
    NumberFormat rp = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
    
    // Mengambil notifikasi session
    String alertStatus = (String) session.getAttribute("alertStatus"); // success/error
    String alertMessage = (String) session.getAttribute("alertMessage");
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Master Layanan</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="css/data_layanan.css" rel="stylesheet">

    
</head>
<body>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <% if (alertStatus != null) { %>
        <script>
            Swal.fire({
                icon: '<%= alertStatus %>', // 'success' atau 'error'
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
                    <li class="breadcrumb-item small"><a href="BookingServlet?action=dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item small active">Kelola Layanan</li>
                </ol>
            </nav>
            <h3 class="fw-bold m-0">Katalog Layanan</h3>
        </div>
        
        <button onclick="openAddModal()" class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm" style="background: #4361ee; border: none;">
            <i class="fas fa-plus me-2"></i> Tambah Layanan
        </button>
    </div>

    <div class="data-card">
        <div class="filter-bar">
            <div>
                <h6 class="fw-bold m-0">Daftar Jasa & Biaya</h6>
                <span class="text-muted small">Total <span class="fw-bold"><%= (listService != null) ? listService.size() : 0 %></span> layanan tersedia</span>
            </div>
            
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="serviceSearch" class="form-input-custom" placeholder="Cari nama layanan...">
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-hover mb-0" id="serviceTable">
                <thead>
                    <tr>
                        <th width="35%">Nama Layanan</th>
                        <th width="30%">Kategori</th>
                        <th width="20%">Biaya Jasa</th>
                        <th width="15%" class="text-end">Opsi</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (listService != null && !listService.isEmpty()) {
                        for (Service s : listService) {
                            // Logika Pewarnaan Badge Kategori
                            String catClass = "bg-default";
                            String catName = (s.getCategory() != null) ? s.getCategory().toLowerCase() : "";
                            
                            if (catName.contains("rutin") || catName.contains("ringan") || catName.contains("berkala")) {
                                catClass = "bg-rutin";
                            } else if (catName.contains("berat") || catName.contains("overhaul") || catName.contains("besar")) {
                                catClass = "bg-berat";
                            }
                    %>
                    <tr>
                        <td>
                            <div class="d-flex align-items-center">
                                <div class="rounded-3 bg-light d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px; color: #4361ee;">
                                    <i class="fas fa-screwdriver-wrench"></i>
                                </div>
                                <div>
                                    <div class="fw-bold text-dark"><%= s.getServiceName() %></div>
                                    <div class="text-muted small" style="font-size: 11px;">ID: SRV-<%= s.getId() %></div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <span class="badge-cat <%= catClass %>">
                                <%= s.getCategory() %>
                            </span>
                        </td>
                        <td>
                            <span class="fw-bold text-dark" style="font-size: 14px;">
                                <%= rp.format(s.getPrice()) %>
                            </span>
                        </td>
                        <td class="text-end">
                            <button class="btn-action btn-edit" 
                                    onclick="openEditModal('<%=s.getId()%>', '<%=s.getServiceName()%>', '<%=s.getCategory()%>', '<%=s.getPrice()%>')"
                                    title="Edit">
                                <i class="fas fa-pen small"></i>
                            </button>
                            <button class="btn-action btn-delete" 
                                    onclick="confirmDelete('<%=s.getId()%>')"
                                    title="Hapus">
                                <i class="fas fa-trash-alt small"></i>
                            </button>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="4" class="text-center py-5">
                            <i class="fas fa-clipboard-list fa-3x mb-3 text-muted opacity-25"></i>
                            <p class="text-muted fw-bold">Belum ada data layanan.</p>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="modal fade" id="serviceModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow" style="border-radius: 20px;">
                <form action="ServiceServlet" method="POST">
                    <div class="modal-header border-0 pb-0 pt-4 px-4">
                        <h5 class="fw-bold" id="modalTitle">Form Layanan</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    
                    <div class="modal-body p-4">
                        <input type="hidden" name="action" id="formAction">
                        <input type="hidden" name="id" id="serviceId">
                        
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted">Nama Layanan</label>
                            <input type="text" name="serviceName" id="inputName" class="form-control rounded-3 py-2" placeholder="Contoh: Ganti Oli" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted">Kategori</label>
                            <input type="text" name="category" id="inputCategory" class="form-control rounded-3 py-2" list="catOptions" placeholder="Pilih atau ketik baru..." required>
                            <datalist id="catOptions">
                                <option value="Servis Rutin">
                                <option value="Servis Berat">
                                <option value="Perbaikan Kaki-kaki">
                                <option value="Kelistrikan">
                                <option value="Body Repair">
                            </datalist>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted">Biaya Jasa</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-0 fw-bold text-muted">Rp</span>
                                <input type="number" name="price" id="inputPrice" class="form-control rounded-end-3 py-2 border-start-0" placeholder="0" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="modal-footer border-0 px-4 pb-4">
                        <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" class="btn btn-primary rounded-pill px-4" style="background: #4361ee; border: none;">Simpan Data</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Init Modal
        const sModal = new bootstrap.Modal(document.getElementById('serviceModal'));

        // FUNGSI: Buka Modal Tambah
        function openAddModal() {
            document.getElementById('modalTitle').innerText = "Tambah Layanan Baru";
            document.getElementById('formAction').value = "add";
            document.getElementById('serviceId').value = "";
            document.getElementById('inputName').value = "";
            document.getElementById('inputCategory').value = "";
            document.getElementById('inputPrice').value = "";
            sModal.show();
        }

        // FUNGSI: Buka Modal Edit
        function openEditModal(id, name, cat, price) {
            document.getElementById('modalTitle').innerText = "Edit Layanan";
            document.getElementById('formAction').value = "update";
            document.getElementById('serviceId').value = id;
            document.getElementById('inputName').value = name;
            document.getElementById('inputCategory').value = cat;
            // Format angka float ke integer string agar rapi di input
            document.getElementById('inputPrice').value = parseFloat(price).toFixed(0);
            sModal.show();
        }

        // FUNGSI: Konfirmasi Hapus
        function confirmDelete(id) {
            Swal.fire({
                title: 'Hapus Layanan?',
                text: "Layanan ini akan dihapus dari database!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc2626',
                cancelButtonColor: '#94a3b8',
                confirmButtonText: 'Ya, Hapus!',
                cancelButtonText: 'Batal'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'ServiceServlet?action=delete&id=' + id;
                }
            })
        }

        // FUNGSI: Live Search
        document.getElementById('serviceSearch').addEventListener('keyup', function() {
            let filter = this.value.toLowerCase();
            let rows = document.querySelectorAll('#serviceTable tbody tr');
            
            rows.forEach(row => {
                if(row.cells.length < 2) return; // Skip row kosong
                let text = row.innerText.toLowerCase();
                row.style.display = text.includes(filter) ? '' : 'none';
            });
        });
    </script>
</body>
</html>