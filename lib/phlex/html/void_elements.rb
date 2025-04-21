# frozen_string_literal: true

# Void HTML elements don't accept content and never have a closing tag.
module Phlex
  class HTML < Phlex::SGML
    module VoidElements
      extend Phlex::SGML::Elements

      # Outputs an `<area>` tag.
      # [MDN Docs](https://developer.mozilla.org/docs/Web/HTML/Element/area)
      # [Spec](https://html.spec.whatwg.org/#the-area-element)
      __register_void_element__ def area(**attributes); nil; end

      # Outputs a `<base>` tag.
      # [MDN Docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base)
      # [Spec](https://html.spec.whatwg.org/#the-base-element)
      __register_void_element__ def base(**attributes); nil; end

      # Outputs a `<br>` tag.
      # [MDN Docs](https://developer.mozilla.org/docs/Web/HTML/Element/br)
      # [Spec](https://html.spec.whatwg.org/#the-br-element)
      __register_void_element__ def br(**attributes); nil; end

      # Outputs a `<col>` tag.
      # [MDN Docs](https://developer.mozilla.org/docs/Web/HTML/Element/col)
      # [Spec](https://html.spec.whatwg.org/#the-col-element)
      __register_void_element__ def col(**attributes); nil; end

      # Outputs an `<embed>` tag.
      # [MDN Docs](https://developer.mozilla.org/docs/Web/HTML/Element/embed)
      # [Spec](https://html.spec.whatwg.org/#the-embed-element)
      __register_void_element__ def embed(**attributes); nil; end

      # Outputs an `<hr>` tag.
      # [MDN Docs](https://developer.mozilla.org/docs/Web/HTML/Element/hr)
      # [Spec](https://html.spec.whatwg.org/#the-hr-element)
      __register_void_element__ def hr(**attributes); nil; end

      # Outputs an `<img>` tag.
      # [MDN Docs](https://developer.mozilla.org/docs/Web/HTML/Element/img)
      # [Spec](https://html.spec.whatwg.org/#the-img-element)
      __register_void_element__ def img(**attributes); nil; end

      # Outputs an `<input>` tag.
      # [MDN Docs](https://developer.mozilla.org/docs/Web/HTML/Element/input)
      # [Spec](https://html.spec.whatwg.org/#the-input-element)
      __register_void_element__ def input(**attributes); nil; end

      # Outputs a `<link>` tag.
      # [MDN Docs](https://developer.mozilla.org/docs/Web/HTML/Element/link)
      # [Spec](https://html.spec.whatwg.org/#the-link-element)
      __register_void_element__ def link(**attributes); nil; end

      # Outputs a `<meta>` tag.
      # [MDN Docs](https://developer.mozilla.org/docs/Web/HTML/Element/meta)
      # [Spec](https://html.spec.whatwg.org/#the-meta-element)
      __register_void_element__ def meta(**attributes); nil; end

      # Outputs a `<source>` tag.
      # [MDN Docs](https://developer.mozilla.org/docs/Web/HTML/Element/source)
      # [Spec](https://html.spec.whatwg.org/#the-source-element)
      __register_void_element__ def source(**attributes); nil; end

      # Outputs a `<track>` tag.
      # [MDN Docs](https://developer.mozilla.org/docs/Web/HTML/Element/track)
      # [Spec](https://html.spec.whatwg.org/#the-track-element)
      __register_void_element__ def track(**attributes); nil; end
    end
  end
end
