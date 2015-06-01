$(function() {
    var groups, projects;

    init_ui();

    // Request groups
    $.ajax({type: 'GET', url: '/gitlab/groups'}).done(function (data) {
        groups = data;

        replace_group_id_with_name(groups);

        $.each(data, function (i, d) {
            $('#entry_group').append('<option value="' + d.id + '">' + d.name + '</option>');
        });

        $('select#entry_group.enhanced').selectpicker('refresh');
    });

    // Request projects
    $.ajax({type: 'GET', url: '/gitlab/projects'}).done(function (data) {
        var group_id;

        projects = data;

        replace_project_id_with_name(projects);

        if (group_id = $('select#entry_group option:selected').val() !== '') {
            update_projects_selector_from(group_id, projects);
        }
    });

    // Setup group selector
    $('select#entry_group').on('change', function (e) {
        var optionSelected = $("option:selected", this);
        if (optionSelected.value !== '') {
            update_projects_selector_from(optionSelected.val(), projects);
        }
    });

    // Setup project selector
    $('select#entry_project').on('change', function (e) {
        var optionSelected = $("option:selected", this);
        if (optionSelected.value !== '') {
            $.when($.ajax({type: 'GET', url: '/gitlab/projects/'+optionSelected.val()+'/issues'})).done(function (issues) {
                update_issues_selector_from(optionSelected.val(), issues);
            });
        }
    });
});

function init_ui() {
    // Patch `classic` select box
    $("select.classic").change(function () {
        if($(this).val() == "0") $(this).addClass("empty");
        else $(this).removeClass("empty")
    });

    // Setup `enhanced` select box
    $('select.enhanced option[value=""]').attr('data-hidden', true);
    $('select.enhanced.optional option[value=""]').attr('data-content', function() {
        return "<i class='fa fa-plus'></i><span class='action'>"+$(this).text()+"</span>";
    });

    // Setup select picker plugin
    $('select.enhanced').selectpicker();
    $('select.enhanced').selectpicker('setStyle', 'bs-select-hidden', 'remove');
    $('select.enhanced').selectpicker('setStyle', 'btn', 'remove');

    // Setup date picker plugin
    $('.time-container input[type="date"]').prop('type','text').datepicker({
        format: "dd/mm/yyyy",
        todayBtn: "linked",
        orientation: "top left",
        todayHighlight: true
    });
}

function replace_group_id_with_name(groups) {
    $('*[data-group-id]').text(function() {
        var group_id = $(this).data('group-id');
        var group = $.grep(groups, function (g) {return g.id === group_id});

        return group.length == 1 ? group[0].name : 'Unknown';
    });
}

function replace_project_id_with_name(projects) {
    $('*[data-project-id]').text(function() {
        var project_id = $(this).data('project-id');
        var project = $.grep(projects, function (p) {return p.id === project_id});

        return project.length == 1 ? project[0].name : 'Unknown';
    });
}

function update_projects_selector_from(group_id, projects) {
    // Remove all option except the placeholder
    $('select#entry_project option[value!=""]').remove();

    // Create new options based on group_id and list of projects
    $.each(projects, function (i, project) {
        if (project.namespace.id === parseInt(group_id)) {
            $('#entry_project').append('<option value="' + project.id + '">' + project.name + '</option>');
        }
    });

    $('select#entry_project.enhanced').selectpicker('refresh');
}

function update_issues_selector_from(project_id, issues) {
    // Remove all option except the placeholder
    $('select#entry_issue option[value!=""]').remove();

    // Create new options based on group_id and list of projects
    $.each(issues, function (i, issue) {
        if (issue.project_id === parseInt(project_id)) {
            $('#entry_issue').append('<option value="' + issue.id + '" data-subtext="'+ issue.title +'"> #' + issue.iid + '</option>');
        }
    });

    $('select#entry_issue.enhanced').selectpicker('refresh');
}
