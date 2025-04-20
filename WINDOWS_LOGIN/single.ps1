# Get AccentColor DWORD from registry
$color = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "AccentColor"

# Convert to hex string (ABGR format)
$hex = '{0:X8}' -f $color

# Extract RGB parts (ignore alpha)
$blue  = $hex.Substring(2,2)
$green = $hex.Substring(4,2)
$red   = $hex.Substring(6,2)

# Build HTML color code
$htmlColor = "#$red$green$blue"

#get lock screen wallpaper
Add-Type -AssemblyName "System.Runtime.WindowsRuntime"
[Windows.System.UserProfile.LockScreen, Windows.System.UserProfile, ContentType = WindowsRuntime] | Out-Null
$imgPath = [Windows.System.UserProfile.LockScreen]::OriginalImageFile.LocalPath
$bytes = [System.IO.File]::ReadAllBytes($imgPath)
$base64 = [Convert]::ToBase64String($bytes)

$body = @"


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login</title>
  <style>
/*! tailwindcss v4.0.17 | MIT License | https://tailwindcss.com */
@layer theme, base, components, utilities;
@layer theme {
  :root, :host {
    --font-sans: ui-sans-serif, system-ui, sans-serif, "Apple Color Emoji",
      "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
    --font-mono: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono",
      "Courier New", monospace;
    --color-red-100: oklch(0.936 0.032 17.717);
    --color-red-200: oklch(0.885 0.062 18.334);
    --color-red-300: oklch(0.808 0.114 19.571);
    --color-red-500: oklch(0.637 0.237 25.331);
    --color-red-800: oklch(0.444 0.177 26.899);
    --color-red-900: oklch(0.396 0.141 25.723);
    --color-amber-200: oklch(0.924 0.12 95.746);
    --color-amber-400: oklch(0.828 0.189 84.429);
    --color-amber-500: oklch(0.769 0.188 70.08);
    --color-amber-600: oklch(0.666 0.179 58.318);
    --color-amber-800: oklch(0.473 0.137 46.201);
    --color-amber-900: oklch(0.414 0.112 45.904);
    --color-green-100: oklch(0.962 0.044 156.743);
    --color-green-200: oklch(0.925 0.084 155.995);
    --color-green-500: oklch(0.723 0.219 149.579);
    --color-green-600: oklch(0.627 0.194 149.214);
    --color-green-800: oklch(0.448 0.119 151.328);
    --color-sky-100: oklch(0.951 0.026 236.824);
    --color-sky-200: oklch(0.901 0.058 230.902);
    --color-sky-500: oklch(0.685 0.169 237.323);
    --color-blue-500: oklch(0.623 0.214 259.815);
    --color-slate-100: oklch(0.968 0.007 247.896);
    --color-slate-900: oklch(0.208 0.042 265.755);
    --color-gray-100: oklch(0.967 0.003 264.542);
    --color-gray-200: oklch(0.928 0.006 264.531);
    --color-gray-300: oklch(0.872 0.01 258.338);
    --color-gray-400: oklch(0.707 0.022 261.325);
    --color-gray-500: oklch(0.551 0.027 264.364);
    --color-gray-700: oklch(0.373 0.034 259.733);
    --color-gray-800: oklch(0.278 0.033 256.848);
    --color-gray-900: oklch(0.21 0.034 264.665);
    --color-black: #000;
    --color-white: #fff;
    --spacing: 0.25rem;
    --text-xs: 0.75rem;
    --text-xs--line-height: calc(1 / 0.75);
    --text-sm: 0.875rem;
    --text-sm--line-height: calc(1.25 / 0.875);
    --text-lg: 1.125rem;
    --text-lg--line-height: calc(1.75 / 1.125);
    --text-xl: 1.25rem;
    --text-xl--line-height: calc(1.75 / 1.25);
    --text-2xl: 1.5rem;
    --text-2xl--line-height: calc(2 / 1.5);
    --text-3xl: 1.875rem;
    --text-3xl--line-height: calc(2.25 / 1.875);
    --text-4xl: 2.25rem;
    --text-4xl--line-height: calc(2.5 / 2.25);
    --text-5xl: 3rem;
    --text-5xl--line-height: 1;
    --text-8xl: 6rem;
    --text-8xl--line-height: 1;
    --font-weight-semibold: 600;
    --font-weight-bold: 700;
    --radius-xs: 0.125rem;
    --radius-sm: 0.25rem;
    --radius-md: 0.375rem;
    --radius-lg: 0.5rem;
    --ease-in: cubic-bezier(0.4, 0, 1, 1);
    --ease-out: cubic-bezier(0, 0, 0.2, 1);
    --ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);
    --animate-spin: spin 1s linear infinite;
    --blur-md: 12px;
    --default-transition-duration: 150ms;
    --default-transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
    --default-font-family: var(--font-sans);
    --default-mono-font-family: var(--font-mono);
  }
}
@layer base {
  *, ::after, ::before, ::backdrop, ::file-selector-button {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    border: 0 solid;
  }
  html, :host {
    line-height: 1.5;
    -webkit-text-size-adjust: 100%;
    tab-size: 4;
    font-family: var(--default-font-family, ui-sans-serif, system-ui, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji");
    font-feature-settings: var(--default-font-feature-settings, normal);
    font-variation-settings: var(--default-font-variation-settings, normal);
    -webkit-tap-highlight-color: transparent;
  }
  hr {
    height: 0;
    color: inherit;
    border-top-width: 1px;
  }
  abbr:where([title]) {
    -webkit-text-decoration: underline dotted;
    text-decoration: underline dotted;
  }
  h1, h2, h3, h4, h5, h6 {
    font-size: inherit;
    font-weight: inherit;
  }
  a {
    color: inherit;
    -webkit-text-decoration: inherit;
    text-decoration: inherit;
  }
  b, strong {
    font-weight: bolder;
  }
  code, kbd, samp, pre {
    font-family: var(--default-mono-font-family, ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace);
    font-feature-settings: var(--default-mono-font-feature-settings, normal);
    font-variation-settings: var(--default-mono-font-variation-settings, normal);
    font-size: 1em;
  }
  small {
    font-size: 80%;
  }
  sub, sup {
    font-size: 75%;
    line-height: 0;
    position: relative;
    vertical-align: baseline;
  }
  sub {
    bottom: -0.25em;
  }
  sup {
    top: -0.5em;
  }
  table {
    text-indent: 0;
    border-color: inherit;
    border-collapse: collapse;
  }
  :-moz-focusring {
    outline: auto;
  }
  progress {
    vertical-align: baseline;
  }
  summary {
    display: list-item;
  }
  ol, ul, menu {
    list-style: none;
  }
  img, svg, video, canvas, audio, iframe, embed, object {
    display: block;
    vertical-align: middle;
  }
  img, video {
    max-width: 100%;
    height: auto;
  }
  button, input, select, optgroup, textarea, ::file-selector-button {
    font: inherit;
    font-feature-settings: inherit;
    font-variation-settings: inherit;
    letter-spacing: inherit;
    color: inherit;
    border-radius: 0;
    background-color: transparent;
    opacity: 1;
  }
  :where(select:is([multiple], [size])) optgroup {
    font-weight: bolder;
  }
  :where(select:is([multiple], [size])) optgroup option {
    padding-inline-start: 20px;
  }
  ::file-selector-button {
    margin-inline-end: 4px;
  }
  ::placeholder {
    opacity: 1;
  }
  @supports (not (-webkit-appearance: -apple-pay-button))  or (contain-intrinsic-size: 1px) {
    ::placeholder {
      color: color-mix(in oklab, currentColor 50%, transparent);
    }
  }
  textarea {
    resize: vertical;
  }
  ::-webkit-search-decoration {
    -webkit-appearance: none;
  }
  ::-webkit-date-and-time-value {
    min-height: 1lh;
    text-align: inherit;
  }
  ::-webkit-datetime-edit {
    display: inline-flex;
  }
  ::-webkit-datetime-edit-fields-wrapper {
    padding: 0;
  }
  ::-webkit-datetime-edit, ::-webkit-datetime-edit-year-field, ::-webkit-datetime-edit-month-field, ::-webkit-datetime-edit-day-field, ::-webkit-datetime-edit-hour-field, ::-webkit-datetime-edit-minute-field, ::-webkit-datetime-edit-second-field, ::-webkit-datetime-edit-millisecond-field, ::-webkit-datetime-edit-meridiem-field {
    padding-block: 0;
  }
  :-moz-ui-invalid {
    box-shadow: none;
  }
  button, input:where([type="button"], [type="reset"], [type="submit"]), ::file-selector-button {
    appearance: button;
  }
  ::-webkit-inner-spin-button, ::-webkit-outer-spin-button {
    height: auto;
  }
  [hidden]:where(:not([hidden="until-found"])) {
    display: none !important;
  }
}
@layer utilities {
  .\@container {
    container-type: inline-size;
  }
  .\@container-\[inline-size\] {
    container-type: inline-size;
  }
  .pointer-events-auto {
    pointer-events: auto;
  }
  .pointer-events-none {
    pointer-events: none;
  }
  .collapse {
    visibility: collapse;
  }
  .invisible {
    visibility: hidden;
  }
  .visible {
    visibility: visible;
  }
  .sr-only {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border-width: 0;
  }
  .not-sr-only {
    position: static;
    width: auto;
    height: auto;
    padding: 0;
    margin: 0;
    overflow: visible;
    clip: auto;
    white-space: normal;
  }
  .absolute {
    position: absolute;
  }
  .fixed {
    position: fixed;
  }
  .relative {
    position: relative;
  }
  .static {
    position: static;
  }
  .sticky {
    position: sticky;
  }
  .inset-0 {
    inset: calc(var(--spacing) * 0);
  }
  .top-0 {
    top: calc(var(--spacing) * 0);
  }
  .top-1 {
    top: calc(var(--spacing) * 1);
  }
  .top-1\/2 {
    top: calc(1/2 * 100%);
  }
  .right-0 {
    right: calc(var(--spacing) * 0);
  }
  .right-1 {
    right: calc(var(--spacing) * 1);
  }
  .right-2 {
    right: calc(var(--spacing) * 2);
  }
  .right-3 {
    right: calc(var(--spacing) * 3);
  }
  .right-7 {
    right: calc(var(--spacing) * 7);
  }
  .bottom-0 {
    bottom: calc(var(--spacing) * 0);
  }
  .bottom-4 {
    bottom: calc(var(--spacing) * 4);
  }
  .bottom-5 {
    bottom: calc(var(--spacing) * 5);
  }
  .left-0 {
    left: calc(var(--spacing) * 0);
  }
  .left-2 {
    left: calc(var(--spacing) * 2);
  }
  .left-4 {
    left: calc(var(--spacing) * 4);
  }
  .left-5 {
    left: calc(var(--spacing) * 5);
  }
  .isolate {
    isolation: isolate;
  }
  .isolation-auto {
    isolation: auto;
  }
  .z-\[999\] {
    z-index: 999;
  }
  .z-auto {
    z-index: auto;
  }
  .order-first {
    order: -9999;
  }
  .order-last {
    order: 9999;
  }
  .order-none {
    order: 0;
  }
  .col-auto {
    grid-column: auto;
  }
  .col-span-1 {
    grid-column: span 1 / span 1;
  }
  .col-span-2 {
    grid-column: span 2 / span 2;
  }
  .col-span-9 {
    grid-column: span 9 / span 9;
  }
  .col-span-11 {
    grid-column: span 11 / span 11;
  }
  .col-span-12 {
    grid-column: span 12 / span 12;
  }
  .col-span-full {
    grid-column: 1 / -1;
  }
  .col-start-auto {
    grid-column-start: auto;
  }
  .col-end-auto {
    grid-column-end: auto;
  }
  .row-auto {
    grid-row: auto;
  }
  .row-span-full {
    grid-row: 1 / -1;
  }
  .row-start-auto {
    grid-row-start: auto;
  }
  .row-end-auto {
    grid-row-end: auto;
  }
  .float-end {
    float: inline-end;
  }
  .float-left {
    float: left;
  }
  .float-none {
    float: none;
  }
  .float-right {
    float: right;
  }
  .float-start {
    float: inline-start;
  }
  .clear-both {
    clear: both;
  }
  .clear-end {
    clear: inline-end;
  }
  .clear-left {
    clear: left;
  }
  .clear-none {
    clear: none;
  }
  .clear-right {
    clear: right;
  }
  .clear-start {
    clear: inline-start;
  }
  .container {
    width: 100%;
    @media (width >= 480px) {
      max-width: 480px;
    }
    @media (width >= 640px) {
      max-width: 640px;
    }
    @media (width >= 768px) {
      max-width: 768px;
    }
    @media (width >= 1024px) {
      max-width: 1024px;
    }
    @media (width >= 1280px) {
      max-width: 1280px;
    }
    @media (width >= 1536px) {
      max-width: 1536px;
    }
    @media (width >= 2560px) {
      max-width: 2560px;
    }
    @media (width >= 7680px) {
      max-width: 7680px;
    }
    @media (width >= 96rem) {
      max-width: 96rem;
    }
  }
  .container\! {
    width: 100% !important;
    @media (width >= 480px) {
      max-width: 480px !important;
    }
    @media (width >= 640px) {
      max-width: 640px !important;
    }
    @media (width >= 768px) {
      max-width: 768px !important;
    }
    @media (width >= 1024px) {
      max-width: 1024px !important;
    }
    @media (width >= 1280px) {
      max-width: 1280px !important;
    }
    @media (width >= 1536px) {
      max-width: 1536px !important;
    }
    @media (width >= 2560px) {
      max-width: 2560px !important;
    }
    @media (width >= 7680px) {
      max-width: 7680px !important;
    }
    @media (width >= 96rem) {
      max-width: 96rem !important;
    }
  }
  .m-4 {
    margin: calc(var(--spacing) * 4);
  }
  .m-10 {
    margin: calc(var(--spacing) * 10);
  }
  .mx-10 {
    margin-inline: calc(var(--spacing) * 10);
  }
  .mx-auto {
    margin-inline: auto;
  }
  .my-7 {
    margin-block: calc(var(--spacing) * 7);
  }
  .my-auto {
    margin-block: auto;
  }
  .mt-4 {
    margin-top: calc(var(--spacing) * 4);
  }
  .mt-5 {
    margin-top: calc(var(--spacing) * 5);
  }
  .mt-7 {
    margin-top: calc(var(--spacing) * 7);
  }
  .mt-10 {
    margin-top: calc(var(--spacing) * 10);
  }
  .mt-11 {
    margin-top: calc(var(--spacing) * 11);
  }
  .mr-3 {
    margin-right: calc(var(--spacing) * 3);
  }
  .mb-4 {
    margin-bottom: calc(var(--spacing) * 4);
  }
  .box-border {
    box-sizing: border-box;
  }
  .box-content {
    box-sizing: content-box;
  }
  .line-clamp-none {
    overflow: visible;
    display: block;
    -webkit-box-orient: horizontal;
    -webkit-line-clamp: unset;
  }
  .block {
    display: block;
  }
  .contents {
    display: contents;
  }
  .flex {
    display: flex;
  }
  .flow-root {
    display: flow-root;
  }
  .grid {
    display: grid;
  }
  .hidden {
    display: none;
  }
  .inline {
    display: inline;
  }
  .inline-block {
    display: inline-block;
  }
  .inline-flex {
    display: inline-flex;
  }
  .inline-grid {
    display: inline-grid;
  }
  .inline-table {
    display: inline-table;
  }
  .list-item {
    display: list-item;
  }
  .table {
    display: table;
  }
  .table-caption {
    display: table-caption;
  }
  .table-cell {
    display: table-cell;
  }
  .table-column {
    display: table-column;
  }
  .table-column-group {
    display: table-column-group;
  }
  .table-footer-group {
    display: table-footer-group;
  }
  .table-header-group {
    display: table-header-group;
  }
  .table-row {
    display: table-row;
  }
  .table-row-group {
    display: table-row-group;
  }
  .field-sizing-content {
    field-sizing: content;
  }
  .field-sizing-fixed {
    field-sizing: fixed;
  }
  .aspect-auto {
    aspect-ratio: auto;
  }
  .aspect-square {
    aspect-ratio: 1 / 1;
  }
  .size-5 {
    width: calc(var(--spacing) * 5);
    height: calc(var(--spacing) * 5);
  }
  .size-6 {
    width: calc(var(--spacing) * 6);
    height: calc(var(--spacing) * 6);
  }
  .size-11 {
    width: calc(var(--spacing) * 11);
    height: calc(var(--spacing) * 11);
  }
  .h-1 {
    height: calc(var(--spacing) * 1);
  }
  .h-1\/2 {
    height: calc(1/2 * 100%);
  }
  .h-2 {
    height: calc(var(--spacing) * 2);
  }
  .h-2\.5 {
    height: calc(var(--spacing) * 2.5);
  }
  .h-3 {
    height: calc(var(--spacing) * 3);
  }
  .h-3\.5 {
    height: calc(var(--spacing) * 3.5);
  }
  .h-4 {
    height: calc(var(--spacing) * 4);
  }
  .h-5 {
    height: calc(var(--spacing) * 5);
  }
  .h-6 {
    height: calc(var(--spacing) * 6);
  }
  .h-7 {
    height: calc(var(--spacing) * 7);
  }
  .h-9 {
    height: calc(var(--spacing) * 9);
  }
  .h-10 {
    height: calc(var(--spacing) * 10);
  }
  .h-11 {
    height: calc(var(--spacing) * 11);
  }
  .h-12 {
    height: calc(var(--spacing) * 12);
  }
  .h-13 {
    height: calc(var(--spacing) * 13);
  }
  .h-14 {
    height: calc(var(--spacing) * 14);
  }
  .h-15 {
    height: calc(var(--spacing) * 15);
  }
  .h-16 {
    height: calc(var(--spacing) * 16);
  }
  .h-44 {
    height: calc(var(--spacing) * 44);
  }
  .h-\[9px\] {
    height: 9px;
  }
  .h-\[10px\] {
    height: 10px;
  }
  .h-screen {
    height: 100vh;
  }
  .max-h-none {
    max-height: none;
  }
  .max-h-screen {
    max-height: 100vh;
  }
  .min-h-screen {
    min-height: 100vh;
  }
  .w-1 {
    width: calc(var(--spacing) * 1);
  }
  .w-1\/2 {
    width: calc(1/2 * 100%);
  }
  .w-2 {
    width: calc(var(--spacing) * 2);
  }
  .w-2\.5 {
    width: calc(var(--spacing) * 2.5);
  }
  .w-3 {
    width: calc(var(--spacing) * 3);
  }
  .w-3\.5 {
    width: calc(var(--spacing) * 3.5);
  }
  .w-4 {
    width: calc(var(--spacing) * 4);
  }
  .w-5 {
    width: calc(var(--spacing) * 5);
  }
  .w-6 {
    width: calc(var(--spacing) * 6);
  }
  .w-7 {
    width: calc(var(--spacing) * 7);
  }
  .w-8 {
    width: calc(var(--spacing) * 8);
  }
  .w-9 {
    width: calc(var(--spacing) * 9);
  }
  .w-10 {
    width: calc(var(--spacing) * 10);
  }
  .w-11 {
    width: calc(var(--spacing) * 11);
  }
  .w-12 {
    width: calc(var(--spacing) * 12);
  }
  .w-13 {
    width: calc(var(--spacing) * 13);
  }
  .w-14 {
    width: calc(var(--spacing) * 14);
  }
  .w-15 {
    width: calc(var(--spacing) * 15);
  }
  .w-16 {
    width: calc(var(--spacing) * 16);
  }
  .w-44 {
    width: calc(var(--spacing) * 44);
  }
  .w-96 {
    width: calc(var(--spacing) * 96);
  }
  .w-\[9px\] {
    width: 9px;
  }
  .w-\[10px\] {
    width: 10px;
  }
  .w-\[255px\] {
    width: 255px;
  }
  .w-full {
    width: 100%;
  }
  .w-screen {
    width: 100vw;
  }
  .max-w-none {
    max-width: none;
  }
  .max-w-screen {
    max-width: 100vw;
  }
  .min-w-screen {
    min-width: 100vw;
  }
  .flex-auto {
    flex: auto;
  }
  .flex-initial {
    flex: 0 auto;
  }
  .flex-none {
    flex: none;
  }
  .flex-shrink {
    flex-shrink: 1;
  }
  .shrink {
    flex-shrink: 1;
  }
  .flex-grow {
    flex-grow: 1;
  }
  .grow {
    flex-grow: 1;
  }
  .basis-auto {
    flex-basis: auto;
  }
  .basis-full {
    flex-basis: 100%;
  }
  .table-auto {
    table-layout: auto;
  }
  .table-fixed {
    table-layout: fixed;
  }
  .caption-bottom {
    caption-side: bottom;
  }
  .caption-top {
    caption-side: top;
  }
  .border-collapse {
    border-collapse: collapse;
  }
  .border-separate {
    border-collapse: separate;
  }
  .origin-bottom {
    transform-origin: bottom;
  }
  .origin-bottom-left {
    transform-origin: bottom left;
  }
  .origin-bottom-right {
    transform-origin: bottom right;
  }
  .origin-center {
    transform-origin: center;
  }
  .origin-left {
    transform-origin: left;
  }
  .origin-right {
    transform-origin: right;
  }
  .origin-top {
    transform-origin: top;
  }
  .origin-top-left {
    transform-origin: top left;
  }
  .origin-top-right {
    transform-origin: top right;
  }
  .-translate-full {
    --tw-translate-x: -100%;
    --tw-translate-y: -100%;
    translate: var(--tw-translate-x) var(--tw-translate-y);
  }
  .translate-full {
    --tw-translate-x: 100%;
    --tw-translate-y: 100%;
    translate: var(--tw-translate-x) var(--tw-translate-y);
  }
  .-translate-y-1 {
    --tw-translate-y: calc(var(--spacing) * -1);
    translate: var(--tw-translate-x) var(--tw-translate-y);
  }
  .-translate-y-1\/2 {
    --tw-translate-y: calc(calc(1/2 * 100%) * -1);
    translate: var(--tw-translate-x) var(--tw-translate-y);
  }
  .translate-3d {
    translate: var(--tw-translate-x) var(--tw-translate-y) var(--tw-translate-z);
  }
  .translate-none {
    translate: none;
  }
  .scale-3d {
    scale: var(--tw-scale-x) var(--tw-scale-y) var(--tw-scale-z);
  }
  .scale-none {
    scale: none;
  }
  .rotate-none {
    rotate: none;
  }
  .transform {
    transform: var(--tw-rotate-x) var(--tw-rotate-y) var(--tw-rotate-z) var(--tw-skew-x) var(--tw-skew-y);
  }
  .transform-cpu {
    transform: var(--tw-rotate-x) var(--tw-rotate-y) var(--tw-rotate-z) var(--tw-skew-x) var(--tw-skew-y);
  }
  .transform-gpu {
    transform: translateZ(0) var(--tw-rotate-x) var(--tw-rotate-y) var(--tw-rotate-z) var(--tw-skew-x) var(--tw-skew-y);
  }
  .transform-none {
    transform: none;
  }
  .animate-none {
    animation: none;
  }
  .animate-spin {
    animation: var(--animate-spin);
  }
  .touch-pinch-zoom {
    --tw-pinch-zoom: pinch-zoom;
    touch-action: var(--tw-pan-x,) var(--tw-pan-y,) var(--tw-pinch-zoom,);
  }
  .resize {
    resize: both;
  }
  .resize-none {
    resize: none;
  }
  .resize-x {
    resize: horizontal;
  }
  .resize-y {
    resize: vertical;
  }
  .snap-none {
    scroll-snap-type: none;
  }
  .snap-mandatory {
    --tw-scroll-snap-strictness: mandatory;
  }
  .snap-proximity {
    --tw-scroll-snap-strictness: proximity;
  }
  .snap-align-none {
    scroll-snap-align: none;
  }
  .snap-center {
    scroll-snap-align: center;
  }
  .snap-end {
    scroll-snap-align: end;
  }
  .snap-start {
    scroll-snap-align: start;
  }
  .snap-always {
    scroll-snap-stop: always;
  }
  .snap-normal {
    scroll-snap-stop: normal;
  }
  .list-inside {
    list-style-position: inside;
  }
  .list-outside {
    list-style-position: outside;
  }
  .list-decimal {
    list-style-type: decimal;
  }
  .list-disc {
    list-style-type: disc;
  }
  .list-none {
    list-style-type: none;
  }
  .list-image-none {
    list-style-image: none;
  }
  .appearance-auto {
    appearance: auto;
  }
  .appearance-none {
    appearance: none;
  }
  .columns-auto {
    columns: auto;
  }
  .auto-cols-auto {
    grid-auto-columns: auto;
  }
  .auto-cols-fr {
    grid-auto-columns: minmax(0, 1fr);
  }
  .auto-cols-max {
    grid-auto-columns: max-content;
  }
  .auto-cols-min {
    grid-auto-columns: min-content;
  }
  .grid-flow-col {
    grid-auto-flow: column;
  }
  .grid-flow-col-dense {
    grid-auto-flow: column dense;
  }
  .grid-flow-dense {
    grid-auto-flow: dense;
  }
  .grid-flow-row {
    grid-auto-flow: row;
  }
  .grid-flow-row-dense {
    grid-auto-flow: row dense;
  }
  .auto-rows-auto {
    grid-auto-rows: auto;
  }
  .auto-rows-fr {
    grid-auto-rows: minmax(0, 1fr);
  }
  .auto-rows-max {
    grid-auto-rows: max-content;
  }
  .auto-rows-min {
    grid-auto-rows: min-content;
  }
  .grid-cols-1 {
    grid-template-columns: repeat(1, minmax(0, 1fr));
  }
  .grid-cols-2 {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
  .grid-cols-3 {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }
  .grid-cols-9 {
    grid-template-columns: repeat(9, minmax(0, 1fr));
  }
  .grid-cols-10 {
    grid-template-columns: repeat(10, minmax(0, 1fr));
  }
  .grid-cols-11 {
    grid-template-columns: repeat(11, minmax(0, 1fr));
  }
  .grid-cols-12 {
    grid-template-columns: repeat(12, minmax(0, 1fr));
  }
  .grid-cols-none {
    grid-template-columns: none;
  }
  .grid-cols-subgrid {
    grid-template-columns: subgrid;
  }
  .grid-rows-none {
    grid-template-rows: none;
  }
  .grid-rows-subgrid {
    grid-template-rows: subgrid;
  }
  .flex-col {
    flex-direction: column;
  }
  .flex-col-reverse {
    flex-direction: column-reverse;
  }
  .flex-row {
    flex-direction: row;
  }
  .flex-row-reverse {
    flex-direction: row-reverse;
  }
  .flex-nowrap {
    flex-wrap: nowrap;
  }
  .flex-wrap {
    flex-wrap: wrap;
  }
  .flex-wrap-reverse {
    flex-wrap: wrap-reverse;
  }
  .place-content-around {
    place-content: space-around;
  }
  .place-content-baseline {
    place-content: baseline;
  }
  .place-content-between {
    place-content: space-between;
  }
  .place-content-center {
    place-content: center;
  }
  .place-content-end {
    place-content: end;
  }
  .place-content-evenly {
    place-content: space-evenly;
  }
  .place-content-start {
    place-content: start;
  }
  .place-content-stretch {
    place-content: stretch;
  }
  .place-items-baseline {
    place-items: baseline;
  }
  .place-items-center {
    place-items: center;
  }
  .place-items-end {
    place-items: end;
  }
  .place-items-start {
    place-items: start;
  }
  .place-items-stretch {
    place-items: stretch;
  }
  .content-around {
    align-content: space-around;
  }
  .content-baseline {
    align-content: baseline;
  }
  .content-between {
    align-content: space-between;
  }
  .content-center {
    align-content: center;
  }
  .content-end {
    align-content: flex-end;
  }
  .content-evenly {
    align-content: space-evenly;
  }
  .content-normal {
    align-content: normal;
  }
  .content-start {
    align-content: flex-start;
  }
  .content-stretch {
    align-content: stretch;
  }
  .items-baseline {
    align-items: baseline;
  }
  .items-center {
    align-items: center;
  }
  .items-end {
    align-items: flex-end;
  }
  .items-start {
    align-items: flex-start;
  }
  .items-stretch {
    align-items: stretch;
  }
  .justify-around {
    justify-content: space-around;
  }
  .justify-baseline {
    justify-content: baseline;
  }
  .justify-between {
    justify-content: space-between;
  }
  .justify-center {
    justify-content: center;
  }
  .justify-end {
    justify-content: flex-end;
  }
  .justify-evenly {
    justify-content: space-evenly;
  }
  .justify-normal {
    justify-content: normal;
  }
  .justify-start {
    justify-content: flex-start;
  }
  .justify-stretch {
    justify-content: stretch;
  }
  .justify-items-center {
    justify-items: center;
  }
  .justify-items-end {
    justify-items: end;
  }
  .justify-items-normal {
    justify-items: normal;
  }
  .justify-items-start {
    justify-items: start;
  }
  .justify-items-stretch {
    justify-items: stretch;
  }
  .gap-1 {
    gap: calc(var(--spacing) * 1);
  }
  .gap-2 {
    gap: calc(var(--spacing) * 2);
  }
  .gap-4 {
    gap: calc(var(--spacing) * 4);
  }
  .gap-11 {
    gap: calc(var(--spacing) * 11);
  }
  .space-y-4 {
    :where(& > :not(:last-child)) {
      --tw-space-y-reverse: 0;
      margin-block-start: calc(calc(var(--spacing) * 4) * var(--tw-space-y-reverse));
      margin-block-end: calc(calc(var(--spacing) * 4) * calc(1 - var(--tw-space-y-reverse)));
    }
  }
  .space-y-reverse {
    :where(& > :not(:last-child)) {
      --tw-space-y-reverse: 1;
    }
  }
  .gap-x-0 {
    column-gap: calc(var(--spacing) * 0);
  }
  .gap-x-1 {
    column-gap: calc(var(--spacing) * 1);
  }
  .gap-x-2 {
    column-gap: calc(var(--spacing) * 2);
  }
  .gap-x-3 {
    column-gap: calc(var(--spacing) * 3);
  }
  .gap-x-4 {
    column-gap: calc(var(--spacing) * 4);
  }
  .gap-x-7 {
    column-gap: calc(var(--spacing) * 7);
  }
  .space-x-reverse {
    :where(& > :not(:last-child)) {
      --tw-space-x-reverse: 1;
    }
  }
  .gap-y-1 {
    row-gap: calc(var(--spacing) * 1);
  }
  .gap-y-2 {
    row-gap: calc(var(--spacing) * 2);
  }
  .gap-y-3 {
    row-gap: calc(var(--spacing) * 3);
  }
  .gap-y-11 {
    row-gap: calc(var(--spacing) * 11);
  }
  .divide-x {
    :where(& > :not(:last-child)) {
      --tw-divide-x-reverse: 0;
      border-inline-style: var(--tw-border-style);
      border-inline-start-width: calc(1px * var(--tw-divide-x-reverse));
      border-inline-end-width: calc(1px * calc(1 - var(--tw-divide-x-reverse)));
    }
  }
  .divide-y {
    :where(& > :not(:last-child)) {
      --tw-divide-y-reverse: 0;
      border-bottom-style: var(--tw-border-style);
      border-top-style: var(--tw-border-style);
      border-top-width: calc(1px * var(--tw-divide-y-reverse));
      border-bottom-width: calc(1px * calc(1 - var(--tw-divide-y-reverse)));
    }
  }
  .divide-y-reverse {
    :where(& > :not(:last-child)) {
      --tw-divide-y-reverse: 1;
    }
  }
  .place-self-auto {
    place-self: auto;
  }
  .place-self-center {
    place-self: center;
  }
  .place-self-end {
    place-self: end;
  }
  .place-self-start {
    place-self: start;
  }
  .place-self-stretch {
    place-self: stretch;
  }
  .self-auto {
    align-self: auto;
  }
  .self-baseline {
    align-self: baseline;
  }
  .self-center {
    align-self: center;
  }
  .self-end {
    align-self: flex-end;
  }
  .self-start {
    align-self: flex-start;
  }
  .self-stretch {
    align-self: stretch;
  }
  .justify-self-auto {
    justify-self: auto;
  }
  .justify-self-center {
    justify-self: center;
  }
  .justify-self-end {
    justify-self: flex-end;
  }
  .justify-self-start {
    justify-self: flex-start;
  }
  .justify-self-stretch {
    justify-self: stretch;
  }
  .truncate {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }
  .overflow-hidden {
    overflow: hidden;
  }
  .scroll-auto {
    scroll-behavior: auto;
  }
  .scroll-smooth {
    scroll-behavior: smooth;
  }
  .rounded {
    border-radius: 0.25rem;
  }
  .rounded-\[3px\] {
    border-radius: 3px;
  }
  .rounded-full {
    border-radius: calc(infinity * 1px);
  }
  .rounded-lg {
    border-radius: var(--radius-lg);
  }
  .rounded-md {
    border-radius: var(--radius-md);
  }
  .rounded-sm {
    border-radius: var(--radius-sm);
  }
  .rounded-xs {
    border-radius: var(--radius-xs);
  }
  .rounded-s {
    border-start-start-radius: 0.25rem;
    border-end-start-radius: 0.25rem;
  }
  .rounded-ss {
    border-start-start-radius: 0.25rem;
  }
  .rounded-e {
    border-start-end-radius: 0.25rem;
    border-end-end-radius: 0.25rem;
  }
  .rounded-se {
    border-start-end-radius: 0.25rem;
  }
  .rounded-ee {
    border-end-end-radius: 0.25rem;
  }
  .rounded-es {
    border-end-start-radius: 0.25rem;
  }
  .rounded-t {
    border-top-left-radius: 0.25rem;
    border-top-right-radius: 0.25rem;
  }
  .rounded-t-md {
    border-top-left-radius: var(--radius-md);
    border-top-right-radius: var(--radius-md);
  }
  .rounded-l {
    border-top-left-radius: 0.25rem;
    border-bottom-left-radius: 0.25rem;
  }
  .rounded-tl {
    border-top-left-radius: 0.25rem;
  }
  .rounded-r {
    border-top-right-radius: 0.25rem;
    border-bottom-right-radius: 0.25rem;
  }
  .rounded-tr {
    border-top-right-radius: 0.25rem;
  }
  .rounded-b {
    border-bottom-right-radius: 0.25rem;
    border-bottom-left-radius: 0.25rem;
  }
  .rounded-br {
    border-bottom-right-radius: 0.25rem;
  }
  .rounded-bl {
    border-bottom-left-radius: 0.25rem;
  }
  .border {
    border-style: var(--tw-border-style);
    border-width: 1px;
  }
  .border-2 {
    border-style: var(--tw-border-style);
    border-width: 2px;
  }
  .border-x {
    border-inline-style: var(--tw-border-style);
    border-inline-width: 1px;
  }
  .border-y {
    border-block-style: var(--tw-border-style);
    border-block-width: 1px;
  }
  .border-s {
    border-inline-start-style: var(--tw-border-style);
    border-inline-start-width: 1px;
  }
  .border-e {
    border-inline-end-style: var(--tw-border-style);
    border-inline-end-width: 1px;
  }
  .border-t {
    border-top-style: var(--tw-border-style);
    border-top-width: 1px;
  }
  .border-r {
    border-right-style: var(--tw-border-style);
    border-right-width: 1px;
  }
  .border-b {
    border-bottom-style: var(--tw-border-style);
    border-bottom-width: 1px;
  }
  .border-b-\[1\.7px\] {
    border-bottom-style: var(--tw-border-style);
    border-bottom-width: 1.7px;
  }
  .border-l {
    border-left-style: var(--tw-border-style);
    border-left-width: 1px;
  }
  .border-dashed {
    --tw-border-style: dashed;
    border-style: dashed;
  }
  .border-dotted {
    --tw-border-style: dotted;
    border-style: dotted;
  }
  .border-double {
    --tw-border-style: double;
    border-style: double;
  }
  .border-hidden {
    --tw-border-style: hidden;
    border-style: hidden;
  }
  .border-none {
    --tw-border-style: none;
    border-style: none;
  }
  .border-solid {
    --tw-border-style: solid;
    border-style: solid;
  }
  .border-gray-200 {
    border-color: var(--color-gray-200);
  }
  .border-gray-300 {
    border-color: var(--color-gray-300);
  }
  .border-gray-700 {
    border-color: var(--color-gray-700);
  }
  .border-gray-900 {
    border-color: var(--color-gray-900);
  }
  .border-b-\[\$htmlColor\] {
    border-bottom-color: $htmlColor;
  }
  .bg-\(--my_variable\) {
    background-color: var(--my_variable);
  }
  .bg-\(color\:--my-color\) {
    background-color: var(--my-color);
  }
  .bg-\[\#0088cc\] {
    background-color: #0088cc;
  }
  .bg-\[\#161B36\] {
    background-color: #161B36;
  }
  .bg-\[\#F3F4F6\] {
    background-color: #F3F4F6;
  }
  .bg-\[color\:var\(--my-color\)\] {
    background-color: var(--my-color);
  }
  .bg-\[var\(--my_variable\)\] {
    background-color: var(--my_variable);
  }
  .bg-amber-200 {
    background-color: var(--color-amber-200);
  }
  .bg-amber-400 {
    background-color: var(--color-amber-400);
  }
  .bg-amber-500 {
    background-color: var(--color-amber-500);
  }
  .bg-amber-600 {
    background-color: var(--color-amber-600);
  }
  .bg-amber-800 {
    background-color: var(--color-amber-800);
  }
  .bg-amber-900 {
    background-color: var(--color-amber-900);
  }
  .bg-black {
    background-color: var(--color-black);
  }
  .bg-blue-500 {
    background-color: var(--color-blue-500);
  }
  .bg-gray-100 {
    background-color: var(--color-gray-100);
  }
  .bg-gray-200 {
    background-color: var(--color-gray-200);
  }
  .bg-gray-300 {
    background-color: var(--color-gray-300);
  }
  .bg-gray-400 {
    background-color: var(--color-gray-400);
  }
  .bg-gray-700 {
    background-color: var(--color-gray-700);
  }
  .bg-gray-800 {
    background-color: var(--color-gray-800);
  }
  .bg-gray-900 {
    background-color: var(--color-gray-900);
  }
  .bg-green-100 {
    background-color: var(--color-green-100);
  }
  .bg-green-200 {
    background-color: var(--color-green-200);
  }
  .bg-green-500 {
    background-color: var(--color-green-500);
  }
  .bg-green-800 {
    background-color: var(--color-green-800);
  }
  .bg-red-100 {
    background-color: var(--color-red-100);
  }
  .bg-red-200 {
    background-color: var(--color-red-200);
  }
  .bg-red-500 {
    background-color: var(--color-red-500);
  }
  .bg-red-500\/50 {
    background-color: color-mix(in oklab, var(--color-red-500) 50%, transparent);
  }
  .bg-red-500\/\[50\%\] {
    background-color: color-mix(in oklab, var(--color-red-500) 50%, transparent);
  }
  .bg-red-800 {
    background-color: var(--color-red-800);
  }
  .bg-red-900 {
    background-color: var(--color-red-900);
  }
  .bg-sky-100 {
    background-color: var(--color-sky-100);
  }
  .bg-sky-200 {
    background-color: var(--color-sky-200);
  }
  .bg-sky-500 {
    background-color: var(--color-sky-500);
  }
  .bg-slate-100 {
    background-color: var(--color-slate-100);
  }
  .bg-slate-900 {
    background-color: var(--color-slate-900);
  }
  .bg-white {
    background-color: var(--color-white);
  }
  .bg-white\/10 {
    background-color: color-mix(in oklab, var(--color-white) 10%, transparent);
  }
  .bg-white\/20 {
    background-color: color-mix(in oklab, var(--color-white) 20%, transparent);
  }
  .-bg-conic {
    --tw-gradient-position: in oklab;
    background-image: conic-gradient(var(--tw-gradient-stops));
  }
  .bg-conic {
    --tw-gradient-position: in oklab;
    background-image: conic-gradient(var(--tw-gradient-stops));
  }
  .bg-gradient-to-br {
    --tw-gradient-position: to bottom right in oklab;
    background-image: linear-gradient(var(--tw-gradient-stops));
  }
  .bg-radial {
    --tw-gradient-position: in oklab;
    background-image: radial-gradient(var(--tw-gradient-stops));
  }
  .bg-none {
    background-image: none;
  }
  .via-none {
    --tw-gradient-via-stops: initial;
  }
  .from-\[\#0f172a\] {
    --tw-gradient-from: #0f172a;
    --tw-gradient-stops: var(--tw-gradient-via-stops, var(--tw-gradient-position), var(--tw-gradient-from) var(--tw-gradient-from-position), var(--tw-gradient-to) var(--tw-gradient-to-position));
  }
  .to-\[\#1e293b\] {
    --tw-gradient-to: #1e293b;
    --tw-gradient-stops: var(--tw-gradient-via-stops, var(--tw-gradient-position), var(--tw-gradient-from) var(--tw-gradient-from-position), var(--tw-gradient-to) var(--tw-gradient-to-position));
  }
  .box-decoration-clone {
    -webkit-box-decoration-break: clone;
    box-decoration-break: clone;
  }
  .box-decoration-slice {
    -webkit-box-decoration-break: slice;
    box-decoration-break: slice;
  }
  .decoration-clone {
    -webkit-box-decoration-break: clone;
    box-decoration-break: clone;
  }
  .decoration-slice {
    -webkit-box-decoration-break: slice;
    box-decoration-break: slice;
  }
  .bg-auto {
    background-size: auto;
  }
  .bg-contain {
    background-size: contain;
  }
  .bg-cover {
    background-size: cover;
  }
  .bg-fixed {
    background-attachment: fixed;
  }
  .bg-local {
    background-attachment: local;
  }
  .bg-scroll {
    background-attachment: scroll;
  }
  .bg-clip-border {
    background-clip: border-box;
  }
  .bg-clip-content {
    background-clip: content-box;
  }
  .bg-clip-padding {
    background-clip: padding-box;
  }
  .bg-clip-text {
    background-clip: text;
  }
  .bg-bottom {
    background-position: bottom;
  }
  .bg-center {
    background-position: center;
  }
  .bg-left {
    background-position: left;
  }
  .bg-left-bottom {
    background-position: left bottom;
  }
  .bg-left-top {
    background-position: left top;
  }
  .bg-right {
    background-position: right;
  }
  .bg-right-bottom {
    background-position: right bottom;
  }
  .bg-right-top {
    background-position: right top;
  }
  .bg-top {
    background-position: top;
  }
  .bg-no-repeat {
    background-repeat: no-repeat;
  }
  .bg-repeat {
    background-repeat: repeat;
  }
  .bg-repeat-round {
    background-repeat: round;
  }
  .bg-repeat-space {
    background-repeat: space;
  }
  .bg-repeat-x {
    background-repeat: repeat-x;
  }
  .bg-repeat-y {
    background-repeat: repeat-y;
  }
  .bg-origin-border {
    background-origin: border-box;
  }
  .bg-origin-content {
    background-origin: content-box;
  }
  .bg-origin-padding {
    background-origin: padding-box;
  }
  .fill-none {
    fill: none;
  }
  .stroke-none {
    stroke: none;
  }
  .object-contain {
    object-fit: contain;
  }
  .object-cover {
    object-fit: cover;
  }
  .object-fill {
    object-fit: fill;
  }
  .object-none {
    object-fit: none;
  }
  .object-scale-down {
    object-fit: scale-down;
  }
  .object-bottom {
    object-position: bottom;
  }
  .object-center {
    object-position: center;
  }
  .object-left {
    object-position: left;
  }
  .object-left-bottom {
    object-position: left bottom;
  }
  .object-left-top {
    object-position: left top;
  }
  .object-right {
    object-position: right;
  }
  .object-right-bottom {
    object-position: right bottom;
  }
  .object-right-top {
    object-position: right top;
  }
  .object-top {
    object-position: top;
  }
  .p-1 {
    padding: calc(var(--spacing) * 1);
  }
  .p-2 {
    padding: calc(var(--spacing) * 2);
  }
  .p-3 {
    padding: calc(var(--spacing) * 3);
  }
  .p-4 {
    padding: calc(var(--spacing) * 4);
  }
  .p-6 {
    padding: calc(var(--spacing) * 6);
  }
  .px-1 {
    padding-inline: calc(var(--spacing) * 1);
  }
  .px-2 {
    padding-inline: calc(var(--spacing) * 2);
  }
  .px-3 {
    padding-inline: calc(var(--spacing) * 3);
  }
  .px-4 {
    padding-inline: calc(var(--spacing) * 4);
  }
  .px-5 {
    padding-inline: calc(var(--spacing) * 5);
  }
  .px-6 {
    padding-inline: calc(var(--spacing) * 6);
  }
  .px-11 {
    padding-inline: calc(var(--spacing) * 11);
  }
  .px-\[2px\] {
    padding-inline: 2px;
  }
  .px-\[3px\] {
    padding-inline: 3px;
  }
  .py-1 {
    padding-block: calc(var(--spacing) * 1);
  }
  .py-2 {
    padding-block: calc(var(--spacing) * 2);
  }
  .py-5 {
    padding-block: calc(var(--spacing) * 5);
  }
  .py-7 {
    padding-block: calc(var(--spacing) * 7);
  }
  .py-11 {
    padding-block: calc(var(--spacing) * 11);
  }
  .py-\[6px\] {
    padding-block: 6px;
  }
  .pt-2 {
    padding-top: calc(var(--spacing) * 2);
  }
  .pb-3 {
    padding-bottom: calc(var(--spacing) * 3);
  }
  .pb-5 {
    padding-bottom: calc(var(--spacing) * 5);
  }
  .pb-7 {
    padding-bottom: calc(var(--spacing) * 7);
  }
  .text-center {
    text-align: center;
  }
  .text-end {
    text-align: end;
  }
  .text-justify {
    text-align: justify;
  }
  .text-left {
    text-align: left;
  }
  .text-right {
    text-align: right;
  }
  .text-start {
    text-align: start;
  }
  .align-baseline {
    vertical-align: baseline;
  }
  .align-bottom {
    vertical-align: bottom;
  }
  .align-middle {
    vertical-align: middle;
  }
  .align-sub {
    vertical-align: sub;
  }
  .align-super {
    vertical-align: super;
  }
  .align-text-bottom {
    vertical-align: text-bottom;
  }
  .align-text-top {
    vertical-align: text-top;
  }
  .align-top {
    vertical-align: top;
  }
  .text-2xl {
    font-size: var(--text-2xl);
    line-height: var(--tw-leading, var(--text-2xl--line-height));
  }
  .text-3xl {
    font-size: var(--text-3xl);
    line-height: var(--tw-leading, var(--text-3xl--line-height));
  }
  .text-4xl {
    font-size: var(--text-4xl);
    line-height: var(--tw-leading, var(--text-4xl--line-height));
  }
  .text-5xl {
    font-size: var(--text-5xl);
    line-height: var(--tw-leading, var(--text-5xl--line-height));
  }
  .text-8xl {
    font-size: var(--text-8xl);
    line-height: var(--tw-leading, var(--text-8xl--line-height));
  }
  .text-lg {
    font-size: var(--text-lg);
    line-height: var(--tw-leading, var(--text-lg--line-height));
  }
  .text-sm {
    font-size: var(--text-sm);
    line-height: var(--tw-leading, var(--text-sm--line-height));
  }
  .text-xl {
    font-size: var(--text-xl);
    line-height: var(--tw-leading, var(--text-xl--line-height));
  }
  .text-xs {
    font-size: var(--text-xs);
    line-height: var(--tw-leading, var(--text-xs--line-height));
  }
  .text-\[20px\] {
    font-size: 20px;
  }
  .leading-none {
    --tw-leading: 1;
    line-height: 1;
  }
  .font-bold {
    --tw-font-weight: var(--font-weight-bold);
    font-weight: var(--font-weight-bold);
  }
  .font-semibold {
    --tw-font-weight: var(--font-weight-semibold);
    font-weight: var(--font-weight-semibold);
  }
  .text-balance {
    text-wrap: balance;
  }
  .text-nowrap {
    text-wrap: nowrap;
  }
  .text-pretty {
    text-wrap: pretty;
  }
  .text-wrap {
    text-wrap: wrap;
  }
  .break-normal {
    overflow-wrap: normal;
    word-break: normal;
  }
  .break-words {
    overflow-wrap: break-word;
  }
  .break-all {
    word-break: break-all;
  }
  .break-keep {
    word-break: keep-all;
  }
  .overflow-ellipsis {
    text-overflow: ellipsis;
  }
  .text-clip {
    text-overflow: clip;
  }
  .text-ellipsis {
    text-overflow: ellipsis;
  }
  .hyphens-auto {
    -webkit-hyphens: auto;
    hyphens: auto;
  }
  .hyphens-manual {
    -webkit-hyphens: manual;
    hyphens: manual;
  }
  .hyphens-none {
    -webkit-hyphens: none;
    hyphens: none;
  }
  .whitespace-break-spaces {
    white-space: break-spaces;
  }
  .whitespace-normal {
    white-space: normal;
  }
  .whitespace-nowrap {
    white-space: nowrap;
  }
  .whitespace-pre {
    white-space: pre;
  }
  .whitespace-pre-line {
    white-space: pre-line;
  }
  .whitespace-pre-wrap {
    white-space: pre-wrap;
  }
  .\[color\:red\] {
    color: red;
  }
  .\[color\:red\]\/50 {
    color: color-mix(in oklab, red 50%, transparent);
  }
  .\[color\:red\]\/50\! {
    color: color-mix(in oklab, red 50%, transparent) !important;
  }
  .text-black {
    color: var(--color-black);
  }
  .text-gray-200 {
    color: var(--color-gray-200);
  }
  .text-gray-300 {
    color: var(--color-gray-300);
  }
  .text-green-600 {
    color: var(--color-green-600);
  }
  .text-red-500 {
    color: var(--color-red-500);
  }
  .text-red-900 {
    color: var(--color-red-900);
  }
  .text-white {
    color: var(--color-white);
  }
  .capitalize {
    text-transform: capitalize;
  }
  .lowercase {
    text-transform: lowercase;
  }
  .normal-case {
    text-transform: none;
  }
  .uppercase {
    text-transform: uppercase;
  }
  .italic {
    font-style: italic;
  }
  .not-italic {
    font-style: normal;
  }
  .font-stretch-condensed {
    font-stretch: condensed;
  }
  .font-stretch-expanded {
    font-stretch: expanded;
  }
  .font-stretch-extra-condensed {
    font-stretch: extra-condensed;
  }
  .font-stretch-extra-expanded {
    font-stretch: extra-expanded;
  }
  .font-stretch-normal {
    font-stretch: normal;
  }
  .font-stretch-semi-condensed {
    font-stretch: semi-condensed;
  }
  .font-stretch-semi-expanded {
    font-stretch: semi-expanded;
  }
  .font-stretch-ultra-condensed {
    font-stretch: ultra-condensed;
  }
  .font-stretch-ultra-expanded {
    font-stretch: ultra-expanded;
  }
  .diagonal-fractions {
    --tw-numeric-fraction: diagonal-fractions;
    font-variant-numeric: var(--tw-ordinal,) var(--tw-slashed-zero,) var(--tw-numeric-figure,) var(--tw-numeric-spacing,) var(--tw-numeric-fraction,);
  }
  .lining-nums {
    --tw-numeric-figure: lining-nums;
    font-variant-numeric: var(--tw-ordinal,) var(--tw-slashed-zero,) var(--tw-numeric-figure,) var(--tw-numeric-spacing,) var(--tw-numeric-fraction,);
  }
  .oldstyle-nums {
    --tw-numeric-figure: oldstyle-nums;
    font-variant-numeric: var(--tw-ordinal,) var(--tw-slashed-zero,) var(--tw-numeric-figure,) var(--tw-numeric-spacing,) var(--tw-numeric-fraction,);
  }
  .ordinal {
    --tw-ordinal: ordinal;
    font-variant-numeric: var(--tw-ordinal,) var(--tw-slashed-zero,) var(--tw-numeric-figure,) var(--tw-numeric-spacing,) var(--tw-numeric-fraction,);
  }
  .proportional-nums {
    --tw-numeric-spacing: proportional-nums;
    font-variant-numeric: var(--tw-ordinal,) var(--tw-slashed-zero,) var(--tw-numeric-figure,) var(--tw-numeric-spacing,) var(--tw-numeric-fraction,);
  }
  .slashed-zero {
    --tw-slashed-zero: slashed-zero;
    font-variant-numeric: var(--tw-ordinal,) var(--tw-slashed-zero,) var(--tw-numeric-figure,) var(--tw-numeric-spacing,) var(--tw-numeric-fraction,);
  }
  .stacked-fractions {
    --tw-numeric-fraction: stacked-fractions;
    font-variant-numeric: var(--tw-ordinal,) var(--tw-slashed-zero,) var(--tw-numeric-figure,) var(--tw-numeric-spacing,) var(--tw-numeric-fraction,);
  }
  .tabular-nums {
    --tw-numeric-spacing: tabular-nums;
    font-variant-numeric: var(--tw-ordinal,) var(--tw-slashed-zero,) var(--tw-numeric-figure,) var(--tw-numeric-spacing,) var(--tw-numeric-fraction,);
  }
  .normal-nums {
    font-variant-numeric: normal;
  }
  .line-through {
    text-decoration-line: line-through;
  }
  .no-underline {
    text-decoration-line: none;
  }
  .overline {
    text-decoration-line: overline;
  }
  .underline {
    text-decoration-line: underline;
  }
  .decoration-dashed {
    text-decoration-style: dashed;
  }
  .decoration-dotted {
    text-decoration-style: dotted;
  }
  .decoration-double {
    text-decoration-style: double;
  }
  .decoration-solid {
    text-decoration-style: solid;
  }
  .decoration-wavy {
    text-decoration-style: wavy;
  }
  .decoration-auto {
    text-decoration-thickness: auto;
  }
  .decoration-from-font {
    text-decoration-thickness: from-font;
  }
  .underline-offset-auto {
    text-underline-offset: auto;
  }
  .antialiased {
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }
  .subpixel-antialiased {
    -webkit-font-smoothing: auto;
    -moz-osx-font-smoothing: auto;
  }
  .accent-auto {
    accent-color: auto;
  }
  .scheme-dark {
    color-scheme: dark;
  }
  .scheme-light {
    color-scheme: light;
  }
  .scheme-light-dark {
    color-scheme: light dark;
  }
  .scheme-normal {
    color-scheme: normal;
  }
  .scheme-only-dark {
    color-scheme: only dark;
  }
  .scheme-only-light {
    color-scheme: only light;
  }
  .opacity-25 {
    opacity: 25%;
  }
  .opacity-75 {
    opacity: 75%;
  }
  .mix-blend-plus-darker {
    mix-blend-mode: plus-darker;
  }
  .mix-blend-plus-lighter {
    mix-blend-mode: plus-lighter;
  }
  .shadow {
    --tw-shadow: 0 1px 3px 0 var(--tw-shadow-color, rgb(0 0 0 / 0.1)), 0 1px 2px -1px var(--tw-shadow-color, rgb(0 0 0 / 0.1));
    box-shadow: var(--tw-inset-shadow), var(--tw-inset-ring-shadow), var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow);
  }
  .shadow-Main {
    --tw-shadow: 0 0 7px 0px var(--tw-shadow-color, rgb(55 55 55 / 33%));
    box-shadow: var(--tw-inset-shadow), var(--tw-inset-ring-shadow), var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow);
  }
  .shadow-lg {
    --tw-shadow: 0 10px 15px -3px var(--tw-shadow-color, rgb(0 0 0 / 0.1)), 0 4px 6px -4px var(--tw-shadow-color, rgb(0 0 0 / 0.1));
    box-shadow: var(--tw-inset-shadow), var(--tw-inset-ring-shadow), var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow);
  }
  .shadow-md {
    --tw-shadow: 0 4px 6px -1px var(--tw-shadow-color, rgb(0 0 0 / 0.1)), 0 2px 4px -2px var(--tw-shadow-color, rgb(0 0 0 / 0.1));
    box-shadow: var(--tw-inset-shadow), var(--tw-inset-ring-shadow), var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow);
  }
  .shadow-sm {
    --tw-shadow: 0 1px 3px 0 var(--tw-shadow-color, rgb(0 0 0 / 0.1)), 0 1px 2px -1px var(--tw-shadow-color, rgb(0 0 0 / 0.1));
    box-shadow: var(--tw-inset-shadow), var(--tw-inset-ring-shadow), var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow);
  }
  .ring {
    --tw-ring-shadow: var(--tw-ring-inset,) 0 0 0 calc(1px + var(--tw-ring-offset-width)) var(--tw-ring-color, currentColor);
    box-shadow: var(--tw-inset-shadow), var(--tw-inset-ring-shadow), var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow);
  }
  .inset-ring {
    --tw-inset-ring-shadow: inset 0 0 0 1px var(--tw-inset-ring-color, currentColor);
    box-shadow: var(--tw-inset-shadow), var(--tw-inset-ring-shadow), var(--tw-ring-offset-shadow), var(--tw-ring-shadow), var(--tw-shadow);
  }
  .shadow-initial {
    --tw-shadow-color: initial;
  }
  .inset-shadow-initial {
    --tw-inset-shadow-color: initial;
  }
  .outline-hidden {
    --tw-outline-style: none;
    outline-style: none;
    @media (forced-colors: active) {
      outline: 2px solid transparent;
      outline-offset: 2px;
    }
  }
  .outline {
    outline-style: var(--tw-outline-style);
    outline-width: 1px;
  }
  .blur {
    --tw-blur: blur(8px);
    filter: var(--tw-blur,) var(--tw-brightness,) var(--tw-contrast,) var(--tw-grayscale,) var(--tw-hue-rotate,) var(--tw-invert,) var(--tw-saturate,) var(--tw-sepia,) var(--tw-drop-shadow,);
  }
  .blur-none {
    --tw-blur:  ;
    filter: var(--tw-blur,) var(--tw-brightness,) var(--tw-contrast,) var(--tw-grayscale,) var(--tw-hue-rotate,) var(--tw-invert,) var(--tw-saturate,) var(--tw-sepia,) var(--tw-drop-shadow,);
  }
  .drop-shadow {
    --tw-drop-shadow: drop-shadow(0 1px 2px rgb(0 0 0 / 0.1)) drop-shadow( 0 1px 1px rgb(0 0 0 / 0.06));
    filter: var(--tw-blur,) var(--tw-brightness,) var(--tw-contrast,) var(--tw-grayscale,) var(--tw-hue-rotate,) var(--tw-invert,) var(--tw-saturate,) var(--tw-sepia,) var(--tw-drop-shadow,);
  }
  .drop-shadow-none {
    --tw-drop-shadow:  ;
    filter: var(--tw-blur,) var(--tw-brightness,) var(--tw-contrast,) var(--tw-grayscale,) var(--tw-hue-rotate,) var(--tw-invert,) var(--tw-saturate,) var(--tw-sepia,) var(--tw-drop-shadow,);
  }
  .grayscale {
    --tw-grayscale: grayscale(100%);
    filter: var(--tw-blur,) var(--tw-brightness,) var(--tw-contrast,) var(--tw-grayscale,) var(--tw-hue-rotate,) var(--tw-invert,) var(--tw-saturate,) var(--tw-sepia,) var(--tw-drop-shadow,);
  }
  .invert {
    --tw-invert: invert(100%);
    filter: var(--tw-blur,) var(--tw-brightness,) var(--tw-contrast,) var(--tw-grayscale,) var(--tw-hue-rotate,) var(--tw-invert,) var(--tw-saturate,) var(--tw-sepia,) var(--tw-drop-shadow,);
  }
  .sepia {
    --tw-sepia: sepia(100%);
    filter: var(--tw-blur,) var(--tw-brightness,) var(--tw-contrast,) var(--tw-grayscale,) var(--tw-hue-rotate,) var(--tw-invert,) var(--tw-saturate,) var(--tw-sepia,) var(--tw-drop-shadow,);
  }
  .filter {
    filter: var(--tw-blur,) var(--tw-brightness,) var(--tw-contrast,) var(--tw-grayscale,) var(--tw-hue-rotate,) var(--tw-invert,) var(--tw-saturate,) var(--tw-sepia,) var(--tw-drop-shadow,);
  }
  .backdrop-blur {
    --tw-backdrop-blur: blur(8px);
    -webkit-backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
    backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
  }
  .backdrop-blur-md {
    --tw-backdrop-blur: blur(var(--blur-md));
    -webkit-backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
    backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
  }
  .backdrop-blur-none {
    --tw-backdrop-blur:  ;
    -webkit-backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
    backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
  }
  .backdrop-grayscale {
    --tw-backdrop-grayscale: grayscale(100%);
    -webkit-backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
    backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
  }
  .backdrop-invert {
    --tw-backdrop-invert: invert(100%);
    -webkit-backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
    backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
  }
  .backdrop-sepia {
    --tw-backdrop-sepia: sepia(100%);
    -webkit-backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
    backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
  }
  .backdrop-filter {
    -webkit-backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
    backdrop-filter: var(--tw-backdrop-blur,) var(--tw-backdrop-brightness,) var(--tw-backdrop-contrast,) var(--tw-backdrop-grayscale,) var(--tw-backdrop-hue-rotate,) var(--tw-backdrop-invert,) var(--tw-backdrop-opacity,) var(--tw-backdrop-saturate,) var(--tw-backdrop-sepia,);
  }
  .transition {
    transition-property: color, background-color, border-color, outline-color, text-decoration-color, fill, stroke, --tw-gradient-from, --tw-gradient-via, --tw-gradient-to, opacity, box-shadow, transform, translate, scale, rotate, filter, -webkit-backdrop-filter, backdrop-filter;
    transition-timing-function: var(--tw-ease, var(--default-transition-timing-function));
    transition-duration: var(--tw-duration, var(--default-transition-duration));
  }
  .transition-all {
    transition-property: all;
    transition-timing-function: var(--tw-ease, var(--default-transition-timing-function));
    transition-duration: var(--tw-duration, var(--default-transition-duration));
  }
  .transition-colors {
    transition-property: color, background-color, border-color, outline-color, text-decoration-color, fill, stroke, --tw-gradient-from, --tw-gradient-via, --tw-gradient-to;
    transition-timing-function: var(--tw-ease, var(--default-transition-timing-function));
    transition-duration: var(--tw-duration, var(--default-transition-duration));
  }
  .transition-opacity {
    transition-property: opacity;
    transition-timing-function: var(--tw-ease, var(--default-transition-timing-function));
    transition-duration: var(--tw-duration, var(--default-transition-duration));
  }
  .transition-shadow {
    transition-property: box-shadow;
    transition-timing-function: var(--tw-ease, var(--default-transition-timing-function));
    transition-duration: var(--tw-duration, var(--default-transition-duration));
  }
  .transition-transform {
    transition-property: transform, translate, scale, rotate;
    transition-timing-function: var(--tw-ease, var(--default-transition-timing-function));
    transition-duration: var(--tw-duration, var(--default-transition-duration));
  }
  .transition-none {
    transition-property: none;
  }
  .transition-discrete {
    transition-behavior: allow-discrete;
  }
  .transition-normal {
    transition-behavior: normal;
  }
  .duration-100 {
    --tw-duration: 100ms;
    transition-duration: 100ms;
  }
  .ease-in {
    --tw-ease: var(--ease-in);
    transition-timing-function: var(--ease-in);
  }
  .ease-in-out {
    --tw-ease: var(--ease-in-out);
    transition-timing-function: var(--ease-in-out);
  }
  .ease-linear {
    --tw-ease: linear;
    transition-timing-function: linear;
  }
  .ease-out {
    --tw-ease: var(--ease-out);
    transition-timing-function: var(--ease-out);
  }
  .will-change-auto {
    will-change: auto;
  }
  .will-change-contents {
    will-change: contents;
  }
  .will-change-scroll {
    will-change: scroll-position;
  }
  .will-change-transform {
    will-change: transform;
  }
  .contain-inline-size {
    --tw-contain-size: inline-size;
    contain: var(--tw-contain-size,) var(--tw-contain-layout,) var(--tw-contain-paint,) var(--tw-contain-style,);
  }
  .contain-layout {
    --tw-contain-layout: layout;
    contain: var(--tw-contain-size,) var(--tw-contain-layout,) var(--tw-contain-paint,) var(--tw-contain-style,);
  }
  .contain-paint {
    --tw-contain-paint: paint;
    contain: var(--tw-contain-size,) var(--tw-contain-layout,) var(--tw-contain-paint,) var(--tw-contain-style,);
  }
  .contain-size {
    --tw-contain-size: size;
    contain: var(--tw-contain-size,) var(--tw-contain-layout,) var(--tw-contain-paint,) var(--tw-contain-style,);
  }
  .contain-style {
    --tw-contain-style: style;
    contain: var(--tw-contain-size,) var(--tw-contain-layout,) var(--tw-contain-paint,) var(--tw-contain-style,);
  }
  .contain-content {
    contain: content;
  }
  .contain-none {
    contain: none;
  }
  .contain-strict {
    contain: strict;
  }
  .content-none {
    --tw-content: none;
    content: none;
  }
  .forced-color-adjust-auto {
    forced-color-adjust: auto;
  }
  .forced-color-adjust-none {
    forced-color-adjust: none;
  }
  .outline-dashed {
    --tw-outline-style: dashed;
    outline-style: dashed;
  }
  .outline-dotted {
    --tw-outline-style: dotted;
    outline-style: dotted;
  }
  .outline-double {
    --tw-outline-style: double;
    outline-style: double;
  }
  .outline-none {
    --tw-outline-style: none;
    outline-style: none;
  }
  .outline-solid {
    --tw-outline-style: solid;
    outline-style: solid;
  }
  .backface-hidden {
    backface-visibility: hidden;
  }
  .backface-visible {
    backface-visibility: visible;
  }
  .divide-x-reverse {
    :where(& > :not(:last-child)) {
      --tw-divide-x-reverse: 1;
    }
  }
  .duration-initial {
    --tw-duration: initial;
  }
  .ease-initial {
    --tw-ease: initial;
  }
  .perspective-none {
    perspective: none;
  }
  .perspective-origin-bottom {
    perspective-origin: bottom;
  }
  .perspective-origin-bottom-left {
    perspective-origin: bottom left;
  }
  .perspective-origin-bottom-right {
    perspective-origin: bottom right;
  }
  .perspective-origin-center {
    perspective-origin: center;
  }
  .perspective-origin-left {
    perspective-origin: left;
  }
  .perspective-origin-right {
    perspective-origin: right;
  }
  .perspective-origin-top {
    perspective-origin: top;
  }
  .perspective-origin-top-left {
    perspective-origin: top left;
  }
  .perspective-origin-top-right {
    perspective-origin: top right;
  }
  .ring-inset {
    --tw-ring-inset: inset;
  }
  .transform-3d {
    transform-style: preserve-3d;
  }
  .transform-border {
    transform-box: border-box;
  }
  .transform-content {
    transform-box: content-box;
  }
  .transform-fill {
    transform-box: fill-box;
  }
  .transform-flat {
    transform-style: flat;
  }
  .transform-stroke {
    transform-box: stroke-box;
  }
  .transform-view {
    transform-box: view-box;
  }
  .\*\:mx-auto {
    :is(& > *) {
      margin-inline: auto;
    }
  }
  .\*\:bg-white {
    :is(& > *) {
      background-color: var(--color-white);
    }
  }
  .\*\:p-2 {
    :is(& > *) {
      padding: calc(var(--spacing) * 2);
    }
  }
  .\*\:px-3 {
    :is(& > *) {
      padding-inline: calc(var(--spacing) * 3);
    }
  }
  .\*\:py-2 {
    :is(& > *) {
      padding-block: calc(var(--spacing) * 2);
    }
  }
  .\*\:font-bold {
    :is(& > *) {
      --tw-font-weight: var(--font-weight-bold);
      font-weight: var(--font-weight-bold);
    }
  }
  .placeholder\:text-gray-300 {
    &::placeholder {
      color: var(--color-gray-300);
    }
  }
  .hover\:cursor-pointer {
    &:hover {
      @media (hover: hover) {
        cursor: pointer;
      }
    }
  }
  .hover\:bg-\[\$htmlColor\] {
    &:hover {
      @media (hover: hover) {
        background-color: $htmlColor;
      }
    }
  }
  .hover\:bg-gray-100\/10 {
    &:hover {
      @media (hover: hover) {
        background-color: color-mix(in oklab, var(--color-gray-100) 10%, transparent);
      }
    }
  }
  .hover\:bg-gray-300 {
    &:hover {
      @media (hover: hover) {
        background-color: var(--color-gray-300);
      }
    }
  }
  .hover\:bg-gray-500 {
    &:hover {
      @media (hover: hover) {
        background-color: var(--color-gray-500);
      }
    }
  }
  .hover\:bg-red-300 {
    &:hover {
      @media (hover: hover) {
        background-color: var(--color-red-300);
      }
    }
  }
  .hover\:text-white {
    &:hover {
      @media (hover: hover) {
        color: var(--color-white);
      }
    }
  }
  .\*\:hover\:cursor-pointer {
    :is(& > *) {
      &:hover {
        @media (hover: hover) {
          cursor: pointer;
        }
      }
    }
  }
  .\*\:hover\:bg-white {
    :is(& > *) {
      &:hover {
        @media (hover: hover) {
          background-color: var(--color-white);
        }
      }
    }
  }
  .\*\:hover\:py-2 {
    :is(& > *) {
      &:hover {
        @media (hover: hover) {
          padding-block: calc(var(--spacing) * 2);
        }
      }
    }
  }
  .xsm\:h-full {
    @media (width >= 480px) {
      height: 100%;
    }
  }
  .sm\:grid {
    @media (width >= 640px) {
      display: grid;
    }
  }
  .sm\:hidden {
    @media (width >= 640px) {
      display: none;
    }
  }
  .sm\:grid-cols-2 {
    @media (width >= 640px) {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }
  }
  .sm\:grid-cols-11 {
    @media (width >= 640px) {
      grid-template-columns: repeat(11, minmax(0, 1fr));
    }
  }
  .sm\:flex-row {
    @media (width >= 640px) {
      flex-direction: row;
    }
  }
  .sm\:items-center {
    @media (width >= 640px) {
      align-items: center;
    }
  }
  .sm\:justify-between {
    @media (width >= 640px) {
      justify-content: space-between;
    }
  }
  .sm\:text-xs {
    @media (width >= 640px) {
      font-size: var(--text-xs);
      line-height: var(--tw-leading, var(--text-xs--line-height));
    }
  }
  .md\:col-span-6 {
    @media (width >= 768px) {
      grid-column: span 6 / span 6;
    }
  }
  .md\:m-10 {
    @media (width >= 768px) {
      margin: calc(var(--spacing) * 10);
    }
  }
  .md\:grid {
    @media (width >= 768px) {
      display: grid;
    }
  }
  .md\:size-6 {
    @media (width >= 768px) {
      width: calc(var(--spacing) * 6);
      height: calc(var(--spacing) * 6);
    }
  }
  .md\:size-7 {
    @media (width >= 768px) {
      width: calc(var(--spacing) * 7);
      height: calc(var(--spacing) * 7);
    }
  }
  .md\:h-6 {
    @media (width >= 768px) {
      height: calc(var(--spacing) * 6);
    }
  }
  .md\:h-15 {
    @media (width >= 768px) {
      height: calc(var(--spacing) * 15);
    }
  }
  .md\:h-\[10px\] {
    @media (width >= 768px) {
      height: 10px;
    }
  }
  .md\:w-9 {
    @media (width >= 768px) {
      width: calc(var(--spacing) * 9);
    }
  }
  .md\:w-15 {
    @media (width >= 768px) {
      width: calc(var(--spacing) * 15);
    }
  }
  .md\:w-\[10px\] {
    @media (width >= 768px) {
      width: 10px;
    }
  }
  .md\:w-full {
    @media (width >= 768px) {
      width: 100%;
    }
  }
  .md\:gap-4 {
    @media (width >= 768px) {
      gap: calc(var(--spacing) * 4);
    }
  }
  .md\:text-sm {
    @media (width >= 768px) {
      font-size: var(--text-sm);
      line-height: var(--tw-leading, var(--text-sm--line-height));
    }
  }
  .lg\:col-span-4 {
    @media (width >= 1024px) {
      grid-column: span 4 / span 4;
    }
  }
  .lg\:grid {
    @media (width >= 1024px) {
      display: grid;
    }
  }
  .lg\:hidden {
    @media (width >= 1024px) {
      display: none;
    }
  }
  .lg\:grid-cols-3 {
    @media (width >= 1024px) {
      grid-template-columns: repeat(3, minmax(0, 1fr));
    }
  }
  .lg\:gap-y-0 {
    @media (width >= 1024px) {
      row-gap: calc(var(--spacing) * 0);
    }
  }
  .lg\:border {
    @media (width >= 1024px) {
      border-style: var(--tw-border-style);
      border-width: 1px;
    }
  }
  .lg\:border-none {
    @media (width >= 1024px) {
      --tw-border-style: none;
      border-style: none;
    }
  }
  .lg\:px-2 {
    @media (width >= 1024px) {
      padding-inline: calc(var(--spacing) * 2);
    }
  }
  .lg\:text-lg {
    @media (width >= 1024px) {
      font-size: var(--text-lg);
      line-height: var(--tw-leading, var(--text-lg--line-height));
    }
  }
  .lg\:text-sm {
    @media (width >= 1024px) {
      font-size: var(--text-sm);
      line-height: var(--tw-leading, var(--text-sm--line-height));
    }
  }
  .lg\:text-xs {
    @media (width >= 1024px) {
      font-size: var(--text-xs);
      line-height: var(--tw-leading, var(--text-xs--line-height));
    }
  }
  .dark\:bg-gray-900 {
    @media (prefers-color-scheme: dark) {
      background-color: var(--color-gray-900);
    }
  }
  .dark\:text-white {
    @media (prefers-color-scheme: dark) {
      color: var(--color-white);
    }
  }
}
@layer base {
  body {
    overflow-x: hidden;
    background-color: rgb(245, 245, 245);
  }
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  .container {
    margin-right: auto;
    margin-left: auto;
  }
  .flex-row-center {
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .flex-col-center {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
  }
}
@layer components;
.login::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    height: 100%;
    width: 100%;
    backdrop-filter: blur(20px);
    z-index: 2;
}
.login {
  position: relative;
  min-height: 100vh;
  background: url('data:image/jpeg;base64,$base64') no-repeat center center / cover;') no-repeat;
  background-position: center;
  background-attachment: fixed;
  background-size: cover;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  z-index: 999;
}
.login::after {
  content: "";
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  z-index: 0;
}
@property --tw-translate-x {
  syntax: "*";
  inherits: false;
  initial-value: 0;
}
@property --tw-translate-y {
  syntax: "*";
  inherits: false;
  initial-value: 0;
}
@property --tw-translate-z {
  syntax: "*";
  inherits: false;
  initial-value: 0;
}
@property --tw-scale-x {
  syntax: "*";
  inherits: false;
  initial-value: 1;
}
@property --tw-scale-y {
  syntax: "*";
  inherits: false;
  initial-value: 1;
}
@property --tw-scale-z {
  syntax: "*";
  inherits: false;
  initial-value: 1;
}
@property --tw-rotate-x {
  syntax: "*";
  inherits: false;
  initial-value: rotateX(0);
}
@property --tw-rotate-y {
  syntax: "*";
  inherits: false;
  initial-value: rotateY(0);
}
@property --tw-rotate-z {
  syntax: "*";
  inherits: false;
  initial-value: rotateZ(0);
}
@property --tw-skew-x {
  syntax: "*";
  inherits: false;
  initial-value: skewX(0);
}
@property --tw-skew-y {
  syntax: "*";
  inherits: false;
  initial-value: skewY(0);
}
@property --tw-pan-x {
  syntax: "*";
  inherits: false;
}
@property --tw-pan-y {
  syntax: "*";
  inherits: false;
}
@property --tw-pinch-zoom {
  syntax: "*";
  inherits: false;
}
@property --tw-scroll-snap-strictness {
  syntax: "*";
  inherits: false;
  initial-value: proximity;
}
@property --tw-space-y-reverse {
  syntax: "*";
  inherits: false;
  initial-value: 0;
}
@property --tw-space-x-reverse {
  syntax: "*";
  inherits: false;
  initial-value: 0;
}
@property --tw-divide-x-reverse {
  syntax: "*";
  inherits: false;
  initial-value: 0;
}
@property --tw-border-style {
  syntax: "*";
  inherits: false;
  initial-value: solid;
}
@property --tw-divide-y-reverse {
  syntax: "*";
  inherits: false;
  initial-value: 0;
}
@property --tw-gradient-position {
  syntax: "*";
  inherits: false;
}
@property --tw-gradient-from {
  syntax: "<color>";
  inherits: false;
  initial-value: #0000;
}
@property --tw-gradient-via {
  syntax: "<color>";
  inherits: false;
  initial-value: #0000;
}
@property --tw-gradient-to {
  syntax: "<color>";
  inherits: false;
  initial-value: #0000;
}
@property --tw-gradient-stops {
  syntax: "*";
  inherits: false;
}
@property --tw-gradient-via-stops {
  syntax: "*";
  inherits: false;
}
@property --tw-gradient-from-position {
  syntax: "<length-percentage>";
  inherits: false;
  initial-value: 0%;
}
@property --tw-gradient-via-position {
  syntax: "<length-percentage>";
  inherits: false;
  initial-value: 50%;
}
@property --tw-gradient-to-position {
  syntax: "<length-percentage>";
  inherits: false;
  initial-value: 100%;
}
@property --tw-leading {
  syntax: "*";
  inherits: false;
}
@property --tw-font-weight {
  syntax: "*";
  inherits: false;
}
@property --tw-ordinal {
  syntax: "*";
  inherits: false;
}
@property --tw-slashed-zero {
  syntax: "*";
  inherits: false;
}
@property --tw-numeric-figure {
  syntax: "*";
  inherits: false;
}
@property --tw-numeric-spacing {
  syntax: "*";
  inherits: false;
}
@property --tw-numeric-fraction {
  syntax: "*";
  inherits: false;
}
@property --tw-shadow {
  syntax: "*";
  inherits: false;
  initial-value: 0 0 #0000;
}
@property --tw-shadow-color {
  syntax: "*";
  inherits: false;
}
@property --tw-inset-shadow {
  syntax: "*";
  inherits: false;
  initial-value: 0 0 #0000;
}
@property --tw-inset-shadow-color {
  syntax: "*";
  inherits: false;
}
@property --tw-ring-color {
  syntax: "*";
  inherits: false;
}
@property --tw-ring-shadow {
  syntax: "*";
  inherits: false;
  initial-value: 0 0 #0000;
}
@property --tw-inset-ring-color {
  syntax: "*";
  inherits: false;
}
@property --tw-inset-ring-shadow {
  syntax: "*";
  inherits: false;
  initial-value: 0 0 #0000;
}
@property --tw-ring-inset {
  syntax: "*";
  inherits: false;
}
@property --tw-ring-offset-width {
  syntax: "<length>";
  inherits: false;
  initial-value: 0px;
}
@property --tw-ring-offset-color {
  syntax: "*";
  inherits: false;
  initial-value: #fff;
}
@property --tw-ring-offset-shadow {
  syntax: "*";
  inherits: false;
  initial-value: 0 0 #0000;
}
@property --tw-outline-style {
  syntax: "*";
  inherits: false;
  initial-value: solid;
}
@property --tw-blur {
  syntax: "*";
  inherits: false;
}
@property --tw-brightness {
  syntax: "*";
  inherits: false;
}
@property --tw-contrast {
  syntax: "*";
  inherits: false;
}
@property --tw-grayscale {
  syntax: "*";
  inherits: false;
}
@property --tw-hue-rotate {
  syntax: "*";
  inherits: false;
}
@property --tw-invert {
  syntax: "*";
  inherits: false;
}
@property --tw-opacity {
  syntax: "*";
  inherits: false;
}
@property --tw-saturate {
  syntax: "*";
  inherits: false;
}
@property --tw-sepia {
  syntax: "*";
  inherits: false;
}
@property --tw-drop-shadow {
  syntax: "*";
  inherits: false;
}
@property --tw-backdrop-blur {
  syntax: "*";
  inherits: false;
}
@property --tw-backdrop-brightness {
  syntax: "*";
  inherits: false;
}
@property --tw-backdrop-contrast {
  syntax: "*";
  inherits: false;
}
@property --tw-backdrop-grayscale {
  syntax: "*";
  inherits: false;
}
@property --tw-backdrop-hue-rotate {
  syntax: "*";
  inherits: false;
}
@property --tw-backdrop-invert {
  syntax: "*";
  inherits: false;
}
@property --tw-backdrop-opacity {
  syntax: "*";
  inherits: false;
}
@property --tw-backdrop-saturate {
  syntax: "*";
  inherits: false;
}
@property --tw-backdrop-sepia {
  syntax: "*";
  inherits: false;
}
@property --tw-duration {
  syntax: "*";
  inherits: false;
}
@property --tw-ease {
  syntax: "*";
  inherits: false;
}
@property --tw-contain-size {
  syntax: "*";
  inherits: false;
}
@property --tw-contain-layout {
  syntax: "*";
  inherits: false;
}
@property --tw-contain-paint {
  syntax: "*";
  inherits: false;
}
@property --tw-contain-style {
  syntax: "*";
  inherits: false;
}
@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

  </style>
</head>
<body>
  <section class="login flex-col-center bg-gradient-to-br from-[#0f172a] to-[#1e293b] min-h-screen px-4">
    <div class="z-[999] w-[255px] flex-col-center">
      <div class="w-44 h-44 bg-white/10 bg-opacity-20 rounded-full flex items-center justify-center z-[999]">
        <img  src="http://localhost:12345/user.webp"  class="w-1/2 h-1/2 md:w-full xsm:h-full object-contain rounded-full" />
      </div>

      <h2 id="userTitle" class="text-[20px] font-semibold text-white z-[999] pb-5 pt-2 text-center"></h2>
      
      <div class="login-wrapper z-[999] px-[2px] w-full">
        <form class="flex items-center relative backdrop-blur-md bg-[#161B36] rounded-[3px] overflow-hidden border-b-[1.7px] border-b-[$htmlColor]">
          <div class="flex-row-center w-full px-2">
            <input 
              id="password" 
              type="password" 
              placeholder="Password" 
              class="w-full text-xs px-[3px] py-2 text-gray-300 outline-none placeholder:text-gray-300" 
              autofocus 
            />
            <a href="#" onclick="pass_check()" class="hover:bg-[$htmlColor] p-1 rounded-xs block">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 text-gray-200">
                <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 4.5 21 12m0 0-7.5 7.5M21 12H3" />
              </svg>
            </a>

            <button type="button" class="outline-none hover:bg-gray-100/10 p-1 rounded-xs text-gray-200 text-sm absolute right-7 hover:cursor-pointer flex-row-center px-1 mr-3" onclick="togglePassword()">

              <svg data-testid="password-eye-on" fill="currentColor" class="___12fm75w f1w7gpdv fez10in fg4l7m0" aria-hidden="true" width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                <path d="M3.26 11.6A6.97 6.97 0 0 1 10 6c3.2 0 6.06 2.33 6.74 5.6a.5.5 0 0 0 .98-.2A7.97 7.97 0 0 0 10 5a7.97 7.97 0 0 0-7.72 6.4.5.5 0 0 0 .98.2ZM10 8a3.5 3.5 0 1 0 0 7 3.5 3.5 0 0 0 0-7Zm-2.5 3.5a2.5 2.5 0 1 1 5 0 2.5 2.5 0 0 1-5 0Z" fill="currentColor"></path>
              </svg>
                        

              <svg id="eye-off" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4 hidden">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88"></path>
              </svg>
            </button>
          </div>
        </form>
        

        <a id="reset_password" href="#" class="text-gray-300 mx-auto block text-center text-xs mt-5 hover:text-white transition-all duration-100 hidden">Reset password</a>
        <a id="password_msg_text" class="hidden text-gray-300 mx-auto block text-center text-xs mt-5 hover:text-white transition-all duration-100">The password is incorrect. Try again.</a>
        <div id="password_msg_button" class="hidden w-full flex-row-center py-5" onclick="re_try()">
          <button type="button" class="text-xs mx-auto text-gray-200 border-2 border-gray-200 bg-white/20 rounded-lg px-11 py-[6px]">OK</button>
        </div>
      </div>
    </div>
  </section>

  <script>
    const passwordInput = document.getElementById("password");
    const toggleButton = document.querySelector('button[onclick="togglePassword()"]');
    let status = "0";

    window.addEventListener("DOMContentLoaded", () => {
      fetch("/user")
        .then(res => res.text())
        .then(name => {
          document.getElementById("userTitle").textContent = name;
        });
        fetch("/user.webp")
        .then(res => res.text())
        .then(name => {
          document.getElementById("userwebp").textContent = name;
        });
      toggleButton.classList.add("hidden");
      passwordInput.focus();
    });

    passwordInput.addEventListener("input", () => {
      toggleButton.classList.toggle("hidden", passwordInput.value.length === 0);
    });

    function togglePassword() {
      const eye = document.getElementById("eye");
      const eyeOff = document.getElementById("eye-off");

      if (passwordInput.type === "password") {
        passwordInput.type = "text";
      } else {
        passwordInput.type = "password";
      }
    }

    function pass_check() {
      const password = passwordInput.value;

      fetch("/run", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "password=" + encodeURIComponent(password)
      })
      .then(res => res.text())
      .then(result => {
        if (result === "OK") {
          alert('Access Granted');
        } else {
          document.getElementById('password_msg_text').style.display = "block";
          document.querySelector("form").style.display = "none";
          document.getElementById('password_msg_button').style.display = "flex";
        }
      });
    }

    function re_try() {
      document.querySelector("form").style.display = "flex";
      document.getElementById('password_msg_text').style.display = "none";
      document.getElementById('password_msg_button').style.display = "none";
    }

    document.addEventListener("keydown", (e) => {
      if (e.key === "Enter") {
        e.preventDefault();

        if (status === "0") {
          status = "1";
          document.getElementById('reset_password').style.display = "none";
          pass_check();
        } else {
          status = "0";
          re_try();
          document.getElementById('reset_password').style.display = "block";
          passwordInput.value = "";
          passwordInput.focus();
        }
      }
    });
  </script>
</body>
</html>

"@

$ErrorActionPreference= 'silentlycontinue'


# Function: Check local Windows credential using ADSI
function Test-Credential {
    param(
        [string]$Scope = "Local",
        [string]$CredentialUserName = $env:USERNAME,
        [string]$PlainPassword
    )

    $SecurePassword = $PlainPassword | ConvertTo-SecureString -AsPlainText -Force
    $Credential = New-Object System.Management.Automation.PSCredential($CredentialUserName, $SecurePassword)

    try {
        $UserCheck = [ADSI]"WinNT://$env:COMPUTERNAME/$($Credential.UserName)"
        $UserCheck.psbase.Invoke("ChangePassword", $Credential.GetNetworkCredential().Password, $Credential.GetNetworkCredential().Password)
        return $true
    } catch {
        return $false
    }
}
# Function: Check user have password set account

function Test-UserHasPassword {
    param (
        [string]$Username = $env:USERNAME,
        [string]$Domain = $env:COMPUTERNAME
    )

    Add-Type @"
using System;
using System.Runtime.InteropServices;
public class L {
    [DllImport("advapi32.dll", SetLastError = true)]
    public static extern bool LogonUser(string u, string d, string p, int t, int pr, out IntPtr tok);
}
"@ -ErrorAction SilentlyContinue

    $token = [IntPtr]::Zero
    if ([L]::LogonUser($Username, $Domain, "", 2, 0, [ref]$token)) {
        return $false  # No password
    } else {
        return $true   # Password is set
    }
}


#  function  returns the image path user login if it exists
function Get-UserLoginImagePath {
    $regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AccountPicture\Users"
    $sid = ([System.Security.Principal.WindowsIdentity]::GetCurrent()).User.Value
    $key = Get-Item "$regPath\$sid" -ErrorAction SilentlyContinue

    if ($key) {
        $imgPath = $key.GetValue("Image192")
        if (Test-Path $imgPath) {
            return $imgPath
        }
    }
    return $null
}


if(Test-UserHasPassword){
# Start listener
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:12345/")
$listener.Start()
$imagePath = Get-UserLoginImagePath

# Open Edge in Kiosk mode
$edge=Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" `
    -ArgumentList "--kiosk", "--edge-kiosk-type=fullscreen", "http://localhost:12345/", "--disable-features=Translate,msWebOOUI,msPdfOOUI,AutofillServerCommunication,AutofillCreditCard,AutofillAddressProfileSavePrompt,PasswordSuggestions,HelpAppLauncher,QSE,EdgeFeedback" -PassThru

# Serve loop
while ($listener.IsListening) {
    $context  = $listener.GetContext()
    $request  = $context.Request
    $response = $context.Response
    $url      = $request.Url.AbsolutePath
    $method   = $request.HttpMethod

    switch ("$method $url") {
        "GET /" {
            $response.ContentType = "text/html"
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($body)
        }

        "GET /user" {
            $response.ContentType = "text/plain"
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($env:USERNAME)
        }

        "GET /output.css" {
            $response.ContentType = "text/css"
            $body = Get-Content "res/output.css" -Raw -Encoding UTF8
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($body)
        }

        "GET /user.webp" {
            $response.ContentType = "image/webp"
            if ($imagePath) {
            $buffer = [System.IO.File]::ReadAllBytes($imagePath)

            } else {
            $buffer_data = @(82, 73, 70, 70, 114, 4, 0, 0, 87, 69, 66, 80, 86, 80, 56, 76, 102, 4, 0, 0, 47, 249, 64, 62, 16, 117, 248, 150, 36, 201, 146, 36, 201, 182, 236, 255, 127, 26, 235, 126, 113, 83, 21, 173, 91, 183, 139, 222, 35, 36, 1, 0, 88, 70, 82, 170, 116, 214, 182, 109, 219, 182, 189, 251, 181, 109, 239, 240, 117, 182, 109, 219, 182, 109, 219, 24, 123, 154, 9, 200, 175, 255, 191, 254, 255, 250, 255, 47, 103, 214, 82, 127, 145, 117, 83, 161, 248, 240, 83, 100, 235, 176, 197, 21, 90, 154, 115, 206, 236, 107, 12, 69, 155, 15, 170, 129, 232, 179, 211, 98, 149, 31, 68, 164, 24, 232, 55, 223, 53, 252, 232, 147, 221, 105, 26, 56, 150, 120, 107, 125, 38, 135, 254, 224, 244, 121, 136, 199, 186, 205, 194, 78, 143, 219, 190, 239, 63, 245, 142, 201, 174, 77, 224, 90, 60, 132, 62, 208, 195, 121, 219, 3, 75, 156, 141, 68, 208, 71, 14, 27, 23, 86, 99, 128, 216, 68, 24, 232, 67, 239, 192, 6, 155, 66, 136, 133, 20, 208, 7, 159, 217, 27, 66, 140, 103, 251, 195, 103, 54, 195, 242, 98, 127, 252, 93, 141, 176, 238, 126, 225, 93, 77, 32, 198, 243, 253, 202, 158, 13, 32, 218, 83, 232, 165, 158, 142, 240, 137, 153, 208, 107, 103, 6, 143, 171, 167, 208, 139, 61, 205, 208, 161, 241, 232, 222, 212, 239, 138, 156, 73, 170, 253, 234, 113, 3, 199, 219, 171, 253, 242, 185, 226, 102, 118, 191, 254, 134, 77, 45, 233, 251, 214, 12, 26, 83, 39, 119, 1, 115, 196, 76, 13, 89, 9, 134, 154, 152, 89, 1, 21, 209, 138, 144, 241, 246, 174, 12, 99, 69, 140, 96, 23, 114, 6, 12, 237, 100, 41, 114, 197, 75, 58, 89, 41, 70, 143, 151, 193, 93, 204, 12, 215, 114, 163, 28, 185, 254, 62, 17, 235, 91, 57, 198, 137, 150, 198, 93, 208, 241, 15, 40, 250, 246, 150, 164, 159, 88, 177, 240, 186, 36, 125, 254, 55, 9, 115, 143, 75, 210, 153, 199, 42, 13, 151, 100, 101, 176, 71, 73, 198, 223, 39, 234, 104, 202, 113, 122, 180, 152, 186, 91, 142, 51, 162, 133, 118, 163, 28, 185, 162, 133, 180, 189, 28, 182, 207, 104, 165, 66, 76, 41, 238, 202, 112, 115, 243, 184, 20, 253, 196, 43, 237, 46, 133, 221, 25, 112, 249, 148, 101, 88, 25, 49, 6, 14, 148, 97, 174, 136, 37, 94, 25, 110, 134, 156, 167, 15, 37, 56, 25, 179, 188, 37, 184, 25, 116, 206, 78, 189, 239, 172, 168, 165, 124, 146, 183, 157, 124, 64, 216, 65, 135, 223, 182, 110, 220, 146, 191, 91, 239, 90, 51, 35, 47, 229, 188, 233, 220, 12, 61, 26, 143, 250, 61, 121, 87, 236, 18, 196, 166, 124, 203, 194, 190, 25, 253, 187, 215, 59, 22, 246, 205, 248, 163, 113, 169, 222, 48, 250, 202, 22, 92, 120, 212, 159, 151, 119, 61, 160, 13, 87, 31, 159, 54, 250, 202, 86, 4, 77, 251, 240, 89, 103, 222, 108, 71, 184, 0, 55, 63, 233, 244, 155, 77, 217, 45, 247, 155, 238, 51, 250, 181, 92, 64, 182, 38, 40, 212, 73, 204, 39, 220, 20, 10, 62, 160, 65, 217, 104, 114, 155, 238, 207, 234, 35, 231, 3, 26, 149, 149, 50, 75, 124, 251, 51, 134, 37, 253, 102, 195, 34, 69, 234, 119, 209, 79, 218, 63, 98, 250, 121, 215, 65, 102, 235, 50, 227, 143, 103, 142, 157, 68, 196, 73, 241, 75, 39, 115, 116, 115, 238, 100, 246, 128, 70, 102, 40, 104, 79, 117, 118, 218, 49, 231, 236, 234, 248, 239, 61, 242, 255, 139, 133, 137, 85, 172, 176, 216, 121, 122, 96, 184, 203, 176, 213, 17, 191, 32, 76, 177, 119, 31, 182, 202, 88, 33, 129, 113, 54, 225, 37, 53, 6, 42, 252, 77, 47, 199, 234, 225, 64, 203, 243, 138, 6, 170, 226, 153, 99, 5, 131, 133, 141, 254, 238, 106, 206, 193, 34, 20, 204, 109, 131, 170, 154, 204, 3, 1, 183, 26, 170, 236, 133, 199, 65, 142, 239, 181, 185, 39, 12, 44, 221, 223, 213, 29, 61, 10, 218, 105, 235, 51, 181, 7, 129, 141, 123, 80, 133, 215, 140, 129, 40, 127, 107, 52, 87, 12, 44, 216, 85, 62, 49, 176, 186, 78, 55, 4, 252, 124, 173, 211, 226, 23, 1, 17, 228, 117, 74, 17, 255, 235, 130, 181, 43, 117, 242, 79, 112, 4, 210, 178, 58, 217, 132, 104, 183, 158, 127, 241, 41, 38, 169, 209, 201, 24, 112, 245, 163, 70, 126, 100, 12, 184, 172, 26, 173, 17, 3, 132, 69, 53, 234, 136, 24, 164, 70, 234, 250, 228, 120, 64, 16, 89, 122, 89, 31, 183, 152, 69, 1, 180, 182, 62, 90, 51, 140, 146, 252, 170, 77, 159, 113, 128, 219, 88, 155, 113, 227, 144, 226, 252, 171, 75, 95, 25, 72, 216, 168, 203, 232, 145, 72, 158, 110, 212, 36, 121, 62, 32, 150, 90, 41, 235, 177, 122, 6, 19, 97, 97, 61, 38, 34, 26, 41, 216, 253, 90, 140, 153, 241, 20, 234, 65, 29, 242, 62, 32, 162, 194, 61, 170, 193, 28, 25, 83, 17, 179, 124, 51, 31, 16, 85, 97, 30, 148, 46, 215, 3, 226, 42, 196, 253, 178, 141, 158, 145, 189, 30, 150, 204, 195, 155, 177, 21, 110, 51, 105, 169, 214, 25, 25, 93, 148, 94, 143, 203, 212, 245, 162, 50, 192, 60, 236, 39, 44, 15, 161, 253, 35, 99, 140, 208, 224, 29, 109, 89, 230, 88, 136, 140, 242, 230, 102, 198, 91, 154, 114, 156, 213, 185, 33, 50, 208, 112, 238, 56, 222, 98, 202, 112, 215, 228, 14, 207, 104, 243, 196, 117, 134, 228, 125, 167, 227, 230, 3, 66, 14, 202, 178, 207, 115, 218, 55, 205, 126, 101, 129, 25, 118, 20, 7, 245, 214, 251, 72, 254, 142, 92, 71, 253, 236, 15, 136, 61, 125, 182, 218, 240, 157, 39, 36, 249, 172, 67, 56, 241, 111, 167, 159, 77, 200, 138, 151, 82, 27, 173, 247, 128, 134, 138, 238, 207, 235, 227, 164, 245, 54, 46, 94, 247, 1, 109, 201, 69, 226, 182, 204, 25, 39, 157, 38, 252, 195, 48, 238, 57, 145, 221, 50, 137, 155, 203, 3, 218, 20, 6, 239, 72, 233, 42, 85, 236, 173, 76, 135, 91, 238, 255, 198, 53, 251, 222, 123, 179, 79, 216, 237, 217, 192, 151, 62, 131, 223, 120, 110, 126, 253, 255, 245, 255, 215, 255, 255, 229, 8)
            $buffer = [byte[]]$buffer_data
            }
        }

        

        "POST /run" {
            $reader = New-Object System.IO.StreamReader($request.InputStream)
            $formData = $reader.ReadToEnd()
            $reader.Close()

            $password = [System.Net.WebUtility]::UrlDecode($formData) -replace "^password=", ""

            if (Test-Credential -PlainPassword $password) {
                $buffer = [System.Text.Encoding]::UTF8.GetBytes("OK")
                $edge.Kill()
                exit
            } else {
                $buffer = [System.Text.Encoding]::UTF8.GetBytes("FAIL")
            }
        }

        default {
            $response.StatusCode = 404
            $response.ContentType = "text/plain"
            $buffer = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
        }
    }

    $response.ContentLength64 = $buffer.Length
    $response.OutputStream.Write($buffer, 0, $buffer.Length)
    $response.OutputStream.Close()
}
}
else{
    write-host "❌ User has NO password (empty password accepted)"
}
