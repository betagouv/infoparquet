document.addEventListener('turbolinks:load', () => {
    const elems = document.querySelectorAll('.ip-autocomplete-input')
    elems.forEach (init)
})

function init(elem) {
    if (elem.__ip_autocomplete_input) {
        return
    }

    elem.__ip_autocomplete_input = true
    setValues(elem, [])

    elem.parentElement.style.position = "relative"

    elem.addEventListener ('input', () => {
        if (elem.value.length < 1) {
            return 
        }
        console.log("lll")

        if (elem.dataset.ipAutocompleteInputSourceApiCommunes) {
            getCommunes(elem).then(() => {
                renderList(elem)
            })
        } else if (elem.dataset.ipAutocompleteInputSourceApiUsers) {
            getUsers(elem).then(() => {
                renderList(elem)
            })
        } else if (elem.dataset.ipAutocompleteInputSourceApiNataffs) {
            getNataffs(elem).then(() => {
                renderList(elem)
            })
        }
    })

    elem.addEventListener('keydown', evt => {
        if (evt.keyCode == 40) { // ARROW_DOWN
            if (elem.__ip_autocomplete_input_values.length > elem.__ip_autocomplete_input_selected + 1) {
                elem.__ip_autocomplete_input_selected++
                renderList(elem)
            }
        } else if (evt.keyCode == 38) { //ARROW_UP
            if (elem.__ip_autocomplete_input_selected - 1 >= 0) {
                elem.__ip_autocomplete_input_selected--
                renderList(elem)
            }
        } else if (evt.keyCode == 13) { //ENTER
            evt.preventDefault()
            selectCurrentValue(elem)
        }
    })


}

function hideList(elem) {
    const parent = elem.parentElement
    const list = parent.querySelector('.ip-autocomplete-input-list')
    
    list.innerHTML = ""
}

function renderList(elem) {
    const parent = elem.parentElement
    const list = parent.querySelector('.ip-autocomplete-input-list')

    list.innerHTML = `
        <ul>
            ${elem.__ip_autocomplete_input_values.map((item, i) => `
                <li 
                    class="${i === elem.__ip_autocomplete_input_selected ? 'ip-autocomplete-input--selected' : ''}"
                    data-ip-autocomplete-input-index="${i}"
                >
                    ${item.value} ${item.desc ? ` - ${item.desc}` : ''}
                </li>
            `).join('')}
        </ul>
    `

    list.querySelectorAll('ul li').forEach(li => {
        li.addEventListener('click', evt => {
            elem.__ip_autocomplete_input_selected = parseInt(li.dataset.ipAutocompleteInputIndex)
            selectCurrentValue(elem)
        })
    })
}

function selectCurrentValue(elem) {
    if (elem.__ip_autocomplete_input_values.length <= 0) {
        return
    }
    const item = elem.__ip_autocomplete_input_values[elem.__ip_autocomplete_input_selected]
    elem.value = item.value
    hideList(elem)
    elem.dispatchEvent(new CustomEvent('ip-autocomplete-input-changed', { bubbles: true, detail: item }))
}

function setValues (elem, values) {
    elem.__ip_autocomplete_input_values = values
    elem.__ip_autocomplete_input_selected = 0
}
 
function getCommunes (elem) {
    return fetch (`https://geo.api.gouv.fr/communes?nom=${elem.value}`).then(r => {
        return r.json()
    }).then(data => {
        setValues(elem, data.map (c => ({value: `${c.nom} (${c.codesPostaux[0]})`})))
    })
}

function getUsers (elem) {
    const headers = new Headers()
    headers.append('Accept', "application/json")
    return fetch (`/users?email=${elem.value}`, { headers }).then(r => {
        return r.json()
    }).then(users => {
        setValues(elem, users.map(u => ({value: u.email})))
    })
}


function getNataffs (elem) {
    const headers = new Headers()
    headers.append('Accept', 'application/json')
    return fetch (`/srj/nataffs?search=${elem.value}`, { headers }).then(r => {
        return r.json()
    }).then(nataffs => {
        setValues(elem, nataffs.map(nataff => ({value: nataff.code, desc: nataff.desc})))
    })
}