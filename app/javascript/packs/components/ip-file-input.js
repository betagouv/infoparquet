document.addEventListener('turbolinks:load', () => {
    const elems = document.querySelectorAll('.ip-file-input')
    elems.forEach (init)
})


function init(elem) {
    console.log(elem)
    if (elem.__ip_file_input) {
        return
    }

    elem.__ip_file_input = true
    elem.__ip_files = elem.dataset.ipFiles ? JSON.parse(elem.dataset.ipFiles) : []
    if(!Array.isArray(elem.__ip_files)) {
        elem.__ip_files = []
    }

    elem.addEventListener("change", evt => renderFiles(elem))

    renderFiles(elem)
}

function renderFiles (elem) {
    const parent = elem.parentElement
    const container = parent.querySelector('.ip-file-input--files')

    if (!container) {
        return
    }

    const multiple = elem.getAttribute('multiple') !== null
    const name = elem.getAttribute('name')

    const newFiles = Array.from(elem.files).map(f => ({filename: f.name}))
    const allFiles = [
        ...elem.__ip_files,
        ...newFiles
    ]

    container.innerHTML = allFiles.map((file, i) => {
        return `
        <span class="fr-tag ${!file.signed_id ? "ip-file-input--files--new-file" : ''}">
            ${file.filename}
            ${file.signed_id ? `<input name="${name}" type="hidden" ${multiple && "multiple"} value="${file.signed_id}" />` : ''}
        </span>
        `
    }).join("")


}