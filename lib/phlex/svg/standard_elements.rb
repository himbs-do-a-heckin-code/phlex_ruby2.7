# frozen_string_literal: true

require_relative '../sgml/elements'

module Phlex
  class SVG < Phlex::SGML
    module StandardElements
    	extend Phlex::SGML::Elements

    	# Outputs an `<a>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/a
    	register_element def a(
    		download: nil,
    		href: nil,
    		hreflang: nil,
    		ping: nil,
    		referrerpolicy: nil,
    		rel: nil,
    		target: nil,
    		type: nil,
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<animate>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/animate
    	register_element def animate(
    		attributeName: nil,
    		values: nil,
    		dur: nil,
    		repeatCount: nil,
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<animateMotion>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/animateMotion
    	register_element def animateMotion(
    		keyPoints: nil,
    		path: nil,
    		rotate: nil,
    		begin: nil,
    		dur: nil,
    		end: nil,
    		repeatCount: nil,
    		repeatDur: nil,
    		fill: nil,
    		calcMode: nil,
    		values: nil,
    		keyTimes: nil,
    		keySplines: nil,
    		from: nil,
    		to: nil,
    		by: nil,
    		attributeName: nil,
    		additive: nil,
    		accumulate: nil,
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<animateTransform>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/animateTransform
    	register_element def animateTransform(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<circle>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/circle
    	register_element def circle(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<clipPath>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/clipPath
    	register_element def clipPath(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<defs>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/defs
    	register_element def defs(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<desc>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/desc
    	register_element def desc(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<discard>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/discard
    	register_element def discard(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<ellipse>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/ellipse
    	register_element def ellipse(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feBlend>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feBlend
    	register_element def feBlend(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feColorMatrix>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feColorMatrix
    	register_element def feColorMatrix(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feComponentTransfer>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feComponentTransfer
    	register_element def feComponentTransfer(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feComposite>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feComposite
    	register_element def feComposite(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feConvolveMatrix>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feConvolveMatrix
    	register_element def feConvolveMatrix(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feDiffuseLighting>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feDiffuseLighting
    	register_element def feDiffuseLighting(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feDisplacementMap>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feDisplacementMap
    	register_element def feDisplacementMap(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feDistantLight>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feDistantLight
    	register_element def feDistantLight(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feDropShadow>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feDropShadow
    	register_element def feDropShadow(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feFlood>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feFlood
    	register_element def feFlood(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feFuncA>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feFuncA
    	register_element def feFuncA(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feFuncB>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feFuncB
    	register_element def feFuncB(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feFuncG>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feFuncG
    	register_element def feFuncG(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feFuncR>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feFuncR
    	register_element def feFuncR(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feGaussianBlur>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feGaussianBlur
    	register_element def feGaussianBlur(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feImage>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feImage
    	register_element def feImage(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feMerge>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feMerge
    	register_element def feMerge(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feMergeNode>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feMergeNode
    	register_element def feMergeNode(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feMorphology>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feMorphology
    	register_element def feMorphology(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feOffset>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feOffset
    	register_element def feOffset(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<fePointLight>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/fePointLight
    	register_element def fePointLight(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feSpecularLighting>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feSpecularLighting
    	register_element def feSpecularLighting(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feSpotLight>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feSpotLight
    	register_element def feSpotLight(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feTile>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feTile
    	register_element def feTile(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<feTurbulence>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/feTurbulence
    	register_element def feTurbulence(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<filter>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/filter
    	register_element def filter(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<foreignObject>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/foreignObject
    	register_element def foreignObject(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<g>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/g
    	register_element def g(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<image>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/image
    	register_element def image(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<line>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/line
    	register_element def line(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<linearGradient>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/linearGradient
    	register_element def linearGradient(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<marker>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/marker
    	register_element def marker(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<mask>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/mask
    	register_element def mask(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<metadata>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/metadata
    	register_element def metadata(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<mpath>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/mpath
    	register_element def mpath(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<path>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/path
    	register_element def path(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<pattern>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/pattern
    	register_element def pattern(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<polygon>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/polygon
    	register_element def polygon(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<polyline>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/polyline
    	register_element def polyline(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<radialGradient>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/radialGradient
    	register_element def radialGradient(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<rect>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/rect
    	register_element def rect(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<script>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/script
    	register_element def script(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<set>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/set
    	register_element def set(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<stop>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/stop
    	register_element def stop(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<style>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/style
    	register_element def style(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs an `<svg>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/svg
    	register_element def svg(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<switch>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/switch
    	register_element def switch(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<symbol>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/symbol
    	register_element def symbol(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<text>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/text
    	register_element def text(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<textPath>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/textPath
    	register_element def textPath(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<title>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/title
    	register_element def title(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<tspan>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/tspan
    	register_element def tspan(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<use>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/use
    	register_element def use(
    		**attributes,
    		&content
    	); nil; end
    	# Outputs a `<view>` tag.
    	# See https://developer.mozilla.org/docs/Web/SVG/Element/view
    	register_element def view(
    		**attributes,
    		&content
    	); nil; end
    end
  end
end
