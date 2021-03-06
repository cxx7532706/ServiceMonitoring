function remove_fields(link){
    $(link).prev("input[type=hidden]").val(1);
    $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
        $(link).parent().before(content.replace(regexp, new_id));
    $(".fields select").last(function(){
        var t = $(this).val();
        if (t==1) {
            show_div($(this).siblings(".one_choice").first());
            hide_div($(this).siblings(".multiple_choice").first());
            hide_div($(this).siblings(".text_answer").first());
        }

        if (t==2) {
            hide_div($(this).siblings(".one_choice").first());
            show_div($(this).siblings(".multiple_choice").first());
            hide_div($(this).siblings(".text_answer").first());
        }

        if (t==3) {
            hide_div($(this).siblings(".one_choice").first());
            hide_div($(this).siblings(".multiple_choice").first());
            show_div($(this).siblings(".text_answer").first());
        }
    });
}
function change_q_type(q_type) {
    var t = $(q_type).val();
    if (t==1) {
        show_div($(q_type).siblings(".one_choice").first());
        hide_div($(q_type).siblings(".multiple_choice").first());
        hide_div($(q_type).siblings(".text_answer").first());
    }

    if (t==2) {
        hide_div($(q_type).siblings(".one_choice").first());
        show_div($(q_type).siblings(".multiple_choice").first());
        hide_div($(q_type).siblings(".text_answer").first());
    }

    if (t==3) {
        hide_div($(q_type).siblings(".one_choice").first());
        hide_div($(q_type).siblings(".multiple_choice").first());
        show_div($(q_type).siblings(".text_answer").first());
    }
}

function hide_div(div_obj) {
    div_obj.hide();
    disabled_change(div_obj, true);
}

function show_div(div_obj) {
    div_obj.show();
    disabled_change(div_obj, false);
}

function disabled_change(div_obj, flg) {
    div_obj.find(':input').attr('disabled', flg);
}

function change_feedback_reference_number(){
    var reference_number =  $('#feedback_reference_number').val();
    var url = $('#prefix_url').val()+'&reference_number='+reference_number;
    $('#feedback_url').text(url);
    $("#d_clip_button").show();
}

function copy_success(){
    alert('Copy Successful');
}

$(document).ready(function() {
    $('#survey_form').submit(function() {
        $(".fields select").each(function(){
            var t = $(this).val();
            if (t==1) {
                show_div($(this).siblings(".one_choice").first());
                hide_div($(this).siblings(".multiple_choice").first());
                hide_div($(this).siblings(".text_answer").first());
            }

            if (t==2) {
                hide_div($(this).siblings(".one_choice").first());
                show_div($(this).siblings(".multiple_choice").first());
                hide_div($(this).siblings(".text_answer").first());
            }

            if (t==3) {
                hide_div($(this).siblings(".one_choice").first());
                hide_div($(this).siblings(".multiple_choice").first());
                show_div($(this).siblings(".text_answer").first());
            }
        });
    });
    var clip = new ZeroClipboard($("#d_clip_button"));
});
