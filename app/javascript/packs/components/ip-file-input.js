import { DirectUpload } from '@rails/activestorage'

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

    elem.addEventListener("change", evt => {
        Array.from(elem.files).forEach(file => uploadFile(elem, file))
        elem.value = null
        renderFiles(elem)
    })
    

    renderFiles(elem)
}

function uploadFile(elem, file) {
    const url = elem.dataset.directUploadUrl
    const fileInfos = {filename: file.name, progress: 0}
    console.log(file)
    const upload = new DirectUpload(file, url, {
        directUploadWillStoreFileWithXHR: (request) => {
            request.upload.addEventListener("progress", evt => {
                fileInfos.progress = Math.floor(evt.loaded / evt.total * 100)
                console.log(fileInfos)
                renderFiles(elem)
            })
        }
    })

    upload.create((error, blob) => {
        if (error) {
            console.error(error)
        } else {
            fileInfos.signed_id = blob.signed_id
            delete fileInfos.progress
            renderFiles(elem)
        }
    })

    elem.__ip_files.push(fileInfos)
}

function renderFiles (elem) {
    const parent = elem.parentElement
    const container = parent.querySelector('.ip-file-input--files')

    if (!container) {
        return
    }

    const multiple = elem.getAttribute('multiple') !== null
    const name = elem.getAttribute('name')

    container.innerHTML = elem.__ip_files.map((file, i) => {
        return `
        <span class="fr-tag ${!file.signed_id ? "ip-file-input--files--new-file" : ''}" data-ip-file-index="${i}">
            ${file.filename}
            ${file.signed_id ? `<input name="${name}" type="hidden" ${multiple && "multiple"} value="${file.signed_id}" />` : ''}
            <span class="fr-fi-close-line"></span>
            ${file.progress ? `<div class="ip-file-input--files--progress" style="width: ${file.progress}%"></div>` : ''}
        </span>
        `
    }).join("")

    container.querySelectorAll('.fr-tag').forEach(file => {
        file.addEventListener('click', evt => {
            elem.__ip_files.splice(parseInt(file.dataset.ipFileIndex), 1)
            renderFiles(elem)
        })
    })


}