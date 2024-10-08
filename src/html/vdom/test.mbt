// test {
//   let node1 = {
//     tag: "div",
//     attrs: { "id": "1", "class": "container" },
//     childrens: [
//       {
//         tag: "h1",
//         attrs: {},
//         childrens: [
//           {
//             tag: "a",
//             attrs: { "href": "https://example.com", "target": "_blank" },
//             childrens: [
//               {
//                 tag: "img",
//                 attrs: {
//                   "src": "https://example.com/image.png",
//                   "alt": "image",
//                   "title": "image",
//                   "width": "100",
//                   "height": "100",
//                   "border": "0",
//                 },
//                 childrens: [
//                   {
//                     tag: "img",
//                     attrs: {
//                       "src": "https://example.com/image.png",
//                       "alt": "image",
//                       "title": "image",
//                       "width": "100",
//                       "height": "100",
//                       "border": "0",
//                     },
//                     childrens: [],
//                   },
//                   {
//                     tag: "img",
//                     attrs: {
//                       "src": "https://example.com/image.png",
//                       "alt": "image",
//                       "title": "image",
//                       "width": "100",
//                       "height": "100",
//                       "border": "0",
//                     },
//                     childrens: [],
//                   },
//                 ],
//               },
//             ],
//           },
//         ],
//       },
//     ],
//   }
//   let node2 = {
//     tag: "div",
//     attrs: { "id": "1", "class": "container" },
//     childrens: [
//       {
//         tag: "h1",
//         attrs: {},
//         childrens: [
//           {
//             tag: "a",
//             attrs: { "href": "https://example.com", "target": "_blank" },
//             childrens: [
//               {
//                 tag: "img",
//                 attrs: {
//                   "src": "https://example.com/image.png",
//                   "alt": "image",
//                   "title": "image",
//                   "width": "100",
//                   "height": "10",
//                   "border": "0",
//                 },
//                 childrens: [
//                   {
//                     tag: "img",
//                     attrs: {
//                       "src": "https://example.com/image.png",
//                       "alt": "image",
//                       "title": "image",
//                       "width": "100",
//                       "height": "100",
//                       "border": "0",
//                     },
//                     childrens: [],
//                   },
//                 ],
//               },
//             ],
//           },
//           {
//             tag: "b",
//             attrs: { "href": "https://example.com", "target": "_blank" },
//             childrens: [
//               {
//                 tag: "img",
//                 attrs: {
//                   "src": "https://example.com/image.png",
//                   "alt": "image",
//                   "title": "image",
//                   "width": "100",
//                   "height": "100",
//                   "border": "0",
//                 },
//                 childrens: [],
//               },
//             ],
//           },
//         ],
//       },
//     ],
//   }
//   let patches = diff(node1, node2)
//   inspect!(
//     @pp.render(patches),
//     content=
//       #|[
//       #|  MutateAttrs(3, {"src": "https://example.com/image.png", "alt": "image", "title": "image", "width": "100", "height": "10", "border": "0"}),
//       #|  Remove(5),
//       #|  InsertAfter(6, {tagName: "b", attrs: {"href": "https://example.com", "target": "_blank"}, childrens: [{tagName: "img", attrs: {"src": "https://example.com/image.png", "alt": "image", "title": "image", "width": "100", "height": "100", "border": "0"}, childrens: []}]})
//       #|]
//     ,
//   )
// }
