class CustomFormBuilder < ActionView::Helpers::FormBuilder
    delegate :tag, :safe_join, to: :@template

    def label(method, text = nil, options = {})
        super(method, text, add_class(options, "fr-label"))
    end

    def ip_label(method, options)
        label(method, options) do
            safe_join [
                options[:label],
                tag.span(class: "fr-hint-text") do
                    options[:hint]
                end
            ]
        end
    end

    def ip_input_group(method, options = {}, &block)
        ip_group(method, "fr-input-group", options, block)
    end

    def ip_checkbox_group(method, options = {}, &block)
        ip_group(method, "fr-checkbox-group", options.merge({before: true}), block)
    end

    def ip_group(method, group_type, options = {}, block)
        tag.div class: group_type do
            safe_join [
                options[:before] ? block.call : nil,
                ip_label(method, options),
                options[:before] ? nil : block.call
            ]
        end
    end

    def text_field(method, options) 
        super(method, add_class(options, "fr-input"))
    end

    def ip_text_field(method, options)
        ip_input_group method, options do
            text_field(method, options)
        end
    end

    def ip_autocomplete_input(method, options)
        safe_join [
            text_field(method, add_class(options, "ip-autocomplete-input").merge({
                "data-ip-autocomplete-input-source-#{options[:data_source]}": true,
                "data-ip-autocomplete-input-query-threshold": options[:query_threshold] || false
            })),
            tag.div(class: 'ip-autocomplete-input-list')
        ]
    end

    def ip_tags_input(method, options)
        ip_input_group method, options do
            tag.div(class: 'ip-tags-input', "data-ip-tags": "#{options[:tags]}") do
                safe_join [
                    tag.div(class: 'ip-tags-input-tags'),
                    hidden_field(method, class: "ip-tags-input-hidden-field"),
                    ip_autocomplete_input(method.to_s + "_search", options),
                    tag.div(class: 'ip-autocomplete-input-list')
                ]
            end
        end
    end

    def ip_check_box(method, options)
        ip_checkbox_group(method, options) do
            check_box method, options
        end
    end

    def text_area(method, options)
        super(method, add_class(options, "fr-input"))
    end

    def ip_text_area(method, options = {})
        ip_input_group method, options do
            text_area(method, options)
        end
    end

    def file_field(method, options = {}) 
        super(method, add_class(options, "fr-upload"))
    end
    

    def ip_file_field(method, options = {})
        files = options[:files] || []
        files = files.map { |f| {filename: f.filename, signed_id: f.signed_id} }

        tag.div(class: "fr-upload-group") do
            safe_join [
                tag.div(class: "ip-file-input--files"),
                ip_label(method, options),
                file_field(method, add_class(options, "ip-file-input").merge({
                    "data-ip-files": files.to_json,
                    direct_upload: true
                }))
            ]
        end
    end

    protected
        def add_class(options, cls)
            options[:class] = options.fetch(:class, "").split.append(cls).join(" ")
            options
        end

end