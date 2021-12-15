document.addEventListener('turbolinks:load', () => {
    const elems = document.querySelectorAll('.ip-tags-input')
    elems.forEach (init)
})

function init(elem) {
    if (elem.__ip_tags_input) {
        return
    }

    elem.__ip_tags_input = true
    elem.__ip_tags = elem.dataset.ipTags ? JSON.parse(elem.dataset.ipTags) : []
    if(!Array.isArray(elem.__ip_tags)) {
        elem.__ip_tags = []
    }

    elem.addEventListener('ip-autocomplete-input-changed', evt => {
        evt.target.value = ""
        if (!elem.__ip_tags.includes(evt.detail)) {
            elem.__ip_tags.push(evt.detail)
        }
        renderTags(elem)
    })

    renderTags(elem)

}

function renderTags(elem) {
    const container = elem.querySelector('.ip-tags-input-tags')

    const hiddenField = elem.querySelector('.ip-tags-input-hidden-field')

    hiddenField.value = JSON.stringify(elem.__ip_tags)

    container.innerHTML = elem.__ip_tags.map((tag, i) => {
        return `<span class="fr-tag" data-ip-tag-index="${i}">${tag}<span class="fr-fi-close-line"></span></span>`
    }).join("")

    container.querySelectorAll('.fr-tag').forEach(tag => {
        tag.addEventListener('click', evt => {
            elem.__ip_tags.splice(parseInt(tag.dataset.ipTagIndex), 1)
            renderTags(elem)
        })
    })
}