<%@page import="omat.pbo.servis.mobil.dao.MechanicDAO"%>
<%@page import="omat.pbo.servis.mobil.model.Mechanic"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // LOGIKA DATA (MVC Pattern)
    // Coba ambil data dari Servlet (request attribute)
    List<Mechanic> listMechanic = (List<Mechanic>) request.getAttribute("listMechanic");

    // Fallback: Jika null (akses langsung file jsp), ambil dari DAO
    if (listMechanic == null) {
        MechanicDAO dao = new MechanicDAO();
        listMechanic = dao.getAllMechanics();
    }
    
    // Notifikasi SweetAlert
    String swalSuccess = (String) session.getAttribute("swal_success");
    String swalError = (String) session.getAttribute("swal_error");
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manajemen Mekanik</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="css/data_mekanik.css" rel="stylesheet">

    
</head>
<body>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <% if(swalSuccess != null) { %>
        <script>
            Swal.fire({
                icon: 'success', title: 'Berhasil!', text: '<%= swalSuccess %>',
                showConfirmButton: false, timer: 2000, toast: true, position: 'top-end'
            });
        </script>
        <% session.removeAttribute("swal_success"); %>
    <% } %>
    <% if(swalError != null) { %>
        <script>
            Swal.fire({
                icon: 'error', title: 'Gagal!', text: '<%= swalError %>',
                showConfirmButton: false, timer: 2000, toast: true, position: 'top-end'
            });
        </script>
        <% session.removeAttribute("swal_error"); %>
    <% } %>

    <div class="page-header d-flex justify-content-between align-items-end">
        <div>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-2">
                    <li class="breadcrumb-item small"><a href="BookingServlet?action=dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item small active">Kelola Mekanik</li>
                </ol>
            </nav>
            <h3 class="fw-bold m-0">Manajemen Mekanik</h3>
        </div>
        
        <button onclick="openAddModal()" class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm" style="background: #4361ee; border: none;">
            <i class="fas fa-plus me-2"></i> Tambah Mekanik
        </button>
    </div>

    <div class="data-card">
        <div class="filter-bar">
            <div>
                <h6 class="fw-bold m-0">Personel Bengkel</h6>
                <span class="text-muted small">Total <span class="fw-bold"><%= (listMechanic != null) ? listMechanic.size() : 0 %></span> mekanik aktif</span>
            </div>
            
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="mechanicSearch" class="form-input-custom" placeholder="Cari nama atau keahlian...">
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-hover mb-0" id="mechanicTable">
                <thead>
                    <tr>
                        <th width="35%">Mekanik</th>
                        <th width="30%">Bidang Keahlian</th>
                        <th width="20%">Status Kerja</th>
                        <th width="15%" class="text-end">Opsi</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (listMechanic != null && !listMechanic.isEmpty()) {
                        for (Mechanic m : listMechanic) {
                            boolean isAvail = "Available".equalsIgnoreCase(m.getStatus());
                            String statusClass = isAvail ? "bg-available" : "bg-busy";
                            String statusLabel = isAvail ? "Available" : "On Duty";
                            String initial = (m.getNamaMekanik() != null && m.getNamaMekanik().length() > 0) ? m.getNamaMekanik().substring(0, 1) : "M";
                    %>
                    <tr>
                        <td>
                            <div class="d-flex align-items-center">
                                <div class="mechanic-avatar">
                                    <%= initial %>
                                </div>
                                <div>
                                    <div class="fw-bold text-dark"><%= m.getNamaMekanik() %></div>
                                    <div class="text-muted small" style="font-size: 11px;">ID: MKN-<%= m.getId() %></div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <span class="text-dark fw-medium" style="font-size: 13px;">
                                <i class="fas fa-wrench text-muted small me-2"></i><%= m.getSpesialisasi() %>
                            </span>
                        </td>
                        <td>
                            <span class="badge-status <%= statusClass %>">
                                <%= statusLabel %>
                            </span>
                        </td>
                        <td class="text-end">
                            <button class="btn-action btn-edit" 
                                    onclick="openEditModal('<%=m.getId()%>', '<%=m.getNamaMekanik()%>', '<%=m.getSpesialisasi()%>', '<%=m.getStatus()%>')"
                                    title="Edit Data">
                                <i class="fas fa-pen small"></i>
                            </button>
                            <button class="btn-action btn-delete" 
                                    onclick="confirmDelete('<%=m.getId()%>')"
                                    title="Hapus Data">
                                <i class="fas fa-trash-alt small"></i>
                            </button>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="4" class="text-center py-5">
                            <i class="fas fa-users-slash fa-3x mb-3 text-muted opacity-25"></i>
                            <p class="text-muted fw-bold">Belum ada data mekanik.</p>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="modal fade" id="mechanicModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow" style="border-radius: 20px;">
                <form action="MechanicServlet" method="POST">
                    <div class="modal-header border-0 pb-0 pt-4 px-4">
                        <h5 class="fw-bold" id="modalTitle">Data Mekanik</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body p-4">
                        <input type="hidden" name="action" id="formAction">
                        <input type="hidden" name="id" id="mechanicId">
                        
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted">Nama Lengkap</label>
                            <input type="text" name="nama" id="inputNama" class="form-control rounded-3 py-2" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted">Spesialisasi</label>
                            <select name="spesialisasi" id="inputSpesialisasi" class="form-select rounded-3 py-2">
                                <option value="Mesin">Mesin (Engine)</option>
                                <option value="Kelistrikan">Kelistrikan</option>
                                <option value="Body & Cat">Body & Cat</option>
                                <option value="Ban & Kaki-kaki">Ban & Kaki-kaki</option>
                                <option value="AC & Interior">AC & Interior</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted">Status</label>
                            <select name="status" id="inputStatus" class="form-select rounded-3 py-2">
                                <option value="Available">Available (Tersedia)</option>
                                <option value="Busy">Busy (Sedang Bertugas)</option>
                            </select>
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
        const mechModal = new bootstrap.Modal(document.getElementById('mechanicModal'));

        // FUNGSI: Buka Modal Tambah
        function openAddModal() {
            document.getElementById('modalTitle').innerText = "Tambah Mekanik Baru";
            document.getElementById('formAction').value = "add";
            document.getElementById('mechanicId').value = "";
            document.getElementById('inputNama').value = "";
            document.getElementById('inputSpesialisasi').value = "Mesin"; 
            document.getElementById('inputStatus').value = "Available";
            mechModal.show();
        }

        // FUNGSI: Buka Modal Edit
        function openEditModal(id, nama, spesialisasi, status) {
            document.getElementById('modalTitle').innerText = "Edit Data Mekanik";
            document.getElementById('formAction').value = "update";
            document.getElementById('mechanicId').value = id;
            document.getElementById('inputNama').value = nama;
            document.getElementById('inputSpesialisasi').value = spesialisasi;
            document.getElementById('inputStatus').value = status;
            mechModal.show();
        }

        // FUNGSI: Konfirmasi Hapus
        function confirmDelete(id) {
            Swal.fire({
                title: 'Hapus Mekanik?',
                text: "Data ini tidak dapat dikembalikan!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc2626',
                cancelButtonColor: '#94a3b8',
                confirmButtonText: 'Ya, Hapus!',
                cancelButtonText: 'Batal'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'MechanicServlet?action=delete&id=' + id;
                }
            })
        }

        // FUNGSI: Live Search
        document.getElementById('mechanicSearch').addEventListener('keyup', function() {
            let filter = this.value.toLowerCase();
            let rows = document.querySelectorAll('#mechanicTable tbody tr');
            
            rows.forEach(row => {
                // Skip row "Belum ada data"
                if(row.cells.length < 2) return;
                
                let text = row.innerText.toLowerCase();
                row.style.display = text.includes(filter) ? '' : 'none';
            });
        });
    </script>
</body>
</html>