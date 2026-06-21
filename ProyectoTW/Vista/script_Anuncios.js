// =========================================================
// script_Anuncios.js — Chamba Ya
// =========================================================

// --- Cambio de secciones (navegación SPA) ---
function cambiarSeccion(nombreSeccion, e) {
    document.querySelectorAll('.vista-seccion').forEach(s => s.classList.remove('activo'));
    document.querySelectorAll('.item-lateral').forEach(i => i.classList.remove('activo'));

    const seccionDestino = document.getElementById('seccion-' + nombreSeccion);
    if (seccionDestino) seccionDestino.classList.add('activo');

    if (e && e.currentTarget) {
        e.currentTarget.classList.add('activo');
    }
}

// --- Lógica de Modales ---
function abrirModal(id) {
    const modal = document.getElementById(id);
    if (modal) modal.classList.add('activo');
}
function cerrarModal(id) {
    const modal = document.getElementById(id);
    if (modal) modal.classList.remove('activo');
}

// --- Contador de Caracteres ---
function actualizarContador(el) {
    const contador = document.getElementById('contador-chars');
    if (contador) contador.textContent = `${el.value.length}/200`;
}

// --- Notificaciones (Toasts) ---
function mostrarNotificacion(mensaje, esError = false) {
    const contenedor = document.getElementById('contenedor-notificaciones');
    if (!contenedor) return;
    const toast = document.createElement('div');
    toast.className = 'notificacion';
    const icono = esError ? 'fa-exclamation-circle' : 'fa-check-circle';
    const color  = esError ? 'var(--error)' : 'var(--exito)';
    toast.innerHTML = `<i class="fas ${icono}" style="color:${color}"></i> ${mensaje}`;
    contenedor.appendChild(toast);
    setTimeout(() => toast.remove(), 4000);
}

// --- Sistema de Etiquetas / Categorías ---
const categoriasSeleccionadas = new Map(); // id (int) → nombre (string)

function agregarEtiqueta(nombre, id) {
    id = parseInt(id);
    if (categoriasSeleccionadas.has(id)) return;
    categoriasSeleccionadas.set(id, nombre);
    renderizarEtiquetas();
}

function eliminarEtiqueta(id) {
    id = parseInt(id);
    categoriasSeleccionadas.delete(id);
    renderizarEtiquetas();
}

function renderizarEtiquetas() {
    const div = document.getElementById('contenedor-etiquetas');
    if (!div) return;
    div.innerHTML = '';
    const ids = [];
    categoriasSeleccionadas.forEach((nombre, id) => {
        div.innerHTML += `<span class="etiqueta-seleccionada">${nombre} <i class="fas fa-times" onclick="eliminarEtiqueta(${id})" style="cursor:pointer"></i></span>`;
        ids.push(id);
    });
    const inputOculto = document.getElementById('categorias-ids');
    if (inputOculto) inputOculto.value = ids.join(',');
}

// --- Preparar modal para CREAR un nuevo anuncio ---
function prepararCreacion() {
    const modal = document.getElementById('modal-crear');
    if (!modal) return;

    const form = document.getElementById('formulario-anuncio');
    if (!form) return;

    // Limpiar formulario completo
    form.reset();

    // Textos del modal en modo creación
    const h3 = modal.querySelector('h3');
    if (h3) h3.textContent = 'Publicar Nueva Chamba';
    const submitBtn = modal.querySelector('button[type="submit"]');
    if (submitBtn) submitBtn.textContent = 'Publicar Ahora';

    // Asegurar que el ID esté vacío (crea nuevo)
    const idInput = document.getElementById('form-id-anuncio');
    if (idInput) idInput.value = '';

    // Resetear categorías
    categoriasSeleccionadas.clear();
    renderizarEtiquetas();

    // Actualizar contador de caracteres
    const descInput = document.getElementById('desc-chamba');
    if (descInput) actualizarContador(descInput);

    abrirModal('modal-crear');
}

// --- Abrir modal para EDITAR un anuncio existente ---
// Recibe el botón que fue clickeado (this) y lee los datos desde sus atributos data-*
function abrirEdicion(btn) {
    const modal = document.getElementById('modal-crear');
    if (!modal) return;

    const form = document.getElementById('formulario-anuncio');
    if (!form) return;

    // Textos del modal en modo edición
    const h3 = modal.querySelector('h3');
    if (h3) h3.textContent = 'Editar Anuncio';
    const submitBtn = modal.querySelector('button[type="submit"]');
    if (submitBtn) submitBtn.textContent = 'Guardar Cambios';

    // Leer datos desde atributos data-* usando getAttribute (más fiable que dataset)
    const id           = btn.getAttribute('data-id');
    const titulo       = btn.getAttribute('data-titulo');
    const descripcion  = btn.getAttribute('data-descripcion');
    const estadoBD     = btn.getAttribute('data-estado');     // Disponible | Cancelado
    const ubicacion    = btn.getAttribute('data-ubicacion');
    const pago         = btn.getAttribute('data-pago');
    const modalidad    = btn.getAttribute('data-modalidad');
    const tipo         = btn.getAttribute('data-tipo');
    const categoriasIds    = btn.getAttribute('data-categorias_ids') || '';
    const categoriasNombres = btn.getAttribute('data-categorias_nombres') || '';

    // === CORRECCIÓN BUG 2: Establecer el ID ANTES de cualquier otra operación ===
    const idInput = document.getElementById('form-id-anuncio');
    if (idInput) idInput.value = id;

    // Rellenar campos de texto
    const tituloEl = document.getElementById('titulo-chamba');
    if (tituloEl) tituloEl.value = titulo || '';

    const descEl = document.getElementById('desc-chamba');
    if (descEl) {
        descEl.value = descripcion || '';
        actualizarContador(descEl);
    }

    const ubicacionEl = document.getElementById('ubicacion-chamba');
    if (ubicacionEl) ubicacionEl.value = ubicacion || '';

    const pagoEl = document.getElementById('pago-chamba');
    if (pagoEl) pagoEl.value = pago || '';

    const modalidadEl = document.getElementById('modalidad-chamba');
    if (modalidadEl) modalidadEl.value = modalidad || 'Presencial';

    const tipoEl = document.getElementById('tipo-chamba');
    if (tipoEl) tipoEl.value = tipo || 'Trabajo';

    // === CORRECCIÓN BUG 1: Mapear valor de BD → valor del select del formulario ===
    // La BD guarda: 'Disponible', 'Cancelado', 'En proceso', 'Finalizado'
    // El formulario tiene: 'activo', 'oculto'
    const mapaEstado = {
        'Disponible': 'activo',
        'En proceso': 'activo',
        'Finalizado':  'oculto',
        'Cancelado':   'oculto',
    };
    const estadoEl = document.getElementById('estado-chamba');
    if (estadoEl) estadoEl.value = mapaEstado[estadoBD] || 'activo';

    // Rellenar categorías seleccionadas
    categoriasSeleccionadas.clear();
    if (categoriasIds) {
        const ids    = categoriasIds.split(',');
        const nombres = categoriasNombres.split(',');
        ids.forEach((catId, i) => {
            if (catId) categoriasSeleccionadas.set(parseInt(catId), nombres[i] || '');
        });
    }
    renderizarEtiquetas();

    // Abrir el modal
    abrirModal('modal-crear');
}

// --- Filtro de búsqueda en tiempo real ---
function filtrarAnuncios() {
    const filtro = (document.getElementById('busqueda-global')?.value || '').toLowerCase();
    document.querySelectorAll('#lista-anuncios .tarjeta-horizontal').forEach(tarjeta => {
        const texto = (tarjeta.querySelector('h3')?.textContent || '').toLowerCase();
        tarjeta.style.display = texto.includes(filtro) ? 'flex' : 'none';
    });
}