// jQuery(function() {
//     var tops;
//     tops = $('#outfit_top_id').html();
//     console.log(tops);
//     return $('#outfit_wearer_id').change(function() {
//       var item, options;
//       item = $('#outfit_wearer_id :selected').val();
//       options = $(tops).filter("optgroup[label=" + item + "]").html();
//       console.log(options);
//       if (options) {
//         return $('#outfit_top_id').html(options);
//       } else {
//         return $('#outfit_top_id').empty();
//       }
//     });
//   });


// //   jQuery(function() {
// //     var states;
// //     states = $('#person_state_id').html();
// //     console.log(states);
// //     return $('#person_country_id').change(function() {
// //       var country, options;
// //       country = $('#person_country_id :selected').text();
// //       options = $(states).filter("optgroup[label=" + country + "]").html();
// //       console.log(options);
// //       if (options) {
// //         return $('#person_state_id').html(options);
// //       } else {
// //         return $('#person_state_id').empty();
// //       }
// //     });
// //   });