/* global document$ */
(function () {
    "use strict";

    // Map abbreviations to glossary pages. Add entries as glossary coverage expands.
    var ABBR_TO_PAGE = {
        API: "Dictionary/api/",
        "CI/CD": "Dictionary/ci-cd/",
        CI: "Dictionary/ci-cd/",
        CD: "Dictionary/ci-cd/",
        GH: "Dictionary/github/",
        GitHub: "Dictionary/github/",
        Git: "Dictionary/git/",
        LTS: "Dictionary/lts/",
        MkDocs: "Dictionary/mkdocs/",
        REST: "Dictionary/rest-api/",
        "REST API": "Dictionary/rest-api/",
        YAML: "Dictionary/yaml/"
    };

    function titleCase(value) {
        return value
            .toLowerCase()
            .split(/\s+/)
            .filter(Boolean)
            .map(function (part) {
                return part.charAt(0).toUpperCase() + part.slice(1);
            })
            .join(" ");
    }

    function getAbbreviationText(node) {
        return (node.textContent || "").trim();
    }

    function toAbsoluteHref(path) {
        var scopeBase = "/";
        if (typeof window !== "undefined" && window.__md_scope && window.__md_scope.base) {
            scopeBase = window.__md_scope.base;
        }

        if (!scopeBase.endsWith("/")) {
            scopeBase += "/";
        }

        return scopeBase + path;
    }

    function upgradeAbbreviation(node) {
        if (!node || node.dataset.abbrLinked === "true") {
            return;
        }

        var key = getAbbreviationText(node);
        var target = ABBR_TO_PAGE[key];
        if (!target) {
            return;
        }

        var link = document.createElement("a");
        link.href = toAbsoluteHref(target);
        link.className = "abbr-preview-link";
        link.innerHTML = node.innerHTML;

        // Keep native tooltip text as fallback while enabling preview-on-hover for links.
        if (node.hasAttribute("title")) {
            link.setAttribute("title", node.getAttribute("title"));
        } else {
            link.setAttribute("title", titleCase(key));
        }

        // Mark transformed to avoid repeated wrapping on instant navigation reloads.
        link.dataset.abbrLinked = "true";
        node.replaceWith(link);
    }

    function enhanceAbbreviations() {
        var nodes = document.querySelectorAll("abbr");
        nodes.forEach(upgradeAbbreviation);
    }

    if (typeof document$ !== "undefined" && document$.subscribe) {
        document$.subscribe(function () {
            enhanceAbbreviations();
        });
        return;
    }

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", enhanceAbbreviations);
    } else {
        enhanceAbbreviations();
    }
})();
