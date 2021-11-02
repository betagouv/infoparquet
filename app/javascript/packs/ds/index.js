InfoParquet.ds.index = {
    toggleDossierUrgent (event, checkbox) {
        params = new URLSearchParams(window.location.search)
        params.set("urgence", checkbox.checked)
        params.set("page", 0)

        window.location.href = location.origin + location.pathname + "?" + params.toString()
    }
}