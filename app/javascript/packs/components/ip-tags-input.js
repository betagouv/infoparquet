document.addEventListener('turbolinks:load', () => {
    const elems = document.querySelectorAll('.ip-tags-input')
    elems.forEach (init)
})

function init(elem) {
    console.log(elem)
    if (elem.__ip_tags_input) {
        return
    }

    elem.__ip_tags_input = true
    try {
        elem.__ip_tags = elem.dataset.ipTags ? JSON.parse(elem.dataset.ipTags) : []
    } catch (err) {
        console.error(err)
        elem.__ip_tags = []
    }
    if(!Array.isArray(elem.__ip_tags)) {
        elem.__ip_tags = []
    } else if(elem.__ip_tags.every(v => typeof v === 'string')) {
        elem.__ip_tags = elem.__ip_tags.map(v => ({value: v}))
    } else if(elem.__ip_tags.some(v => v.value === undefined)) {
        elem.__ip_tags = []
    }

    elem.addEventListener('ip-autocomplete-input-changed', evt => {
        evt.target.value = ""
        if (!elem.__ip_tags.some(tag => tag.value === evt.detail.value)) {
            elem.__ip_tags.push(evt.detail)
        }
        renderTags(elem)
        
        const scrollable = elem.parentElement.querySelector('label') || elem
        scrollable.scrollIntoView({block: 'nearest', inline: 'nearest'})
    })

    renderTags(elem)

}

function renderTags(elem) {
    const container = elem.querySelector('.ip-tags-input-tags')

    const hiddenField = elem.querySelector('.ip-tags-input-hidden-field')

    hiddenField.value = JSON.stringify(elem.__ip_tags.map(tag => tag.value))

    container.innerHTML = elem.__ip_tags.map((tag, i) => {
        return `<span class="fr-tag" data-ip-tag-index="${i}">${tag.value} ${tag.desc ? ` - ${tag.desc}` : ''}<span class="fr-fi-close-line"></span></span>`
    }).join("")

    container.querySelectorAll('.fr-tag').forEach(tag => {
        tag.addEventListener('click', evt => {
            elem.__ip_tags.splice(parseInt(tag.dataset.ipTagIndex), 1)
            renderTags(elem)
        })
    })
}