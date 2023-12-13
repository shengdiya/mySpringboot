function onDropdownChange1() {
    var provinceId = document.getElementById("Province").value;
    $('#City').empty();
    $('#County').empty();
    $("#City").append('<option value="">选择市</option>');
    $("#County").append('<option value="">选择县</option>');
    $.ajax({
        url: "species/adminRE1",
        type: "POST",
        data: {
            provinceId: provinceId
        },
        success: function(data) {
            $.each(data, function(index, city) {
                $("#City").append('<option value="' + city.Id + '">' + city.cityName + '</option>');
            });

            console.log(2000);
        },
        error: function(xhr, status, error) {
            console.log("Ajax请求失败：" + error);
            console.log(xhr);
            console.log(status);
        }
    });
}

function onDropdownChange2() {
    var provinceId = document.getElementById("City").value;
    $('#County').empty();
    $.ajax({
        url: "species/adminRE1",
        type: "POST",
        data: {
            provinceId: provinceId
        },
        success: function(data) {
            $("#County").append('<option value="">选择县</option>');
            $.each(data, function(index, city) {
                $("#County").append('<option value="' + city.Id + '">' + city.cityName + '</option>');
            })
            var table = $("#myTable");
            // 清空表格的内容

        },
        error: function(xhr, status, error) {
            $("#County").append('<option value="">选择县</option>');
            console.log("Ajax请求失败：" + error);
            console.log(xhr);
            console.log(status);
        }
    });
}

function onclickupd1() {
    var provinceId = document.getElementById("Province").value;
    var cityId = document.getElementById("City").value;
    var countyId = document.getElementById("County").value;
    var family = document.getElementById("family").value;
    var genus = document.getElementById("genus").value;
    var species = document.getElementById("species").value;
    console.log("'" + family + "'");
    console.log("'" + genus + "'");
    console.log("'" + species + "'");
    if (!family || !genus || !species) {
        // 当输入框中至少有一个为空时的处理逻辑
        alert("请填写完整科属种输入框");
        return;
    }
    $('#Province').empty();
    $('#City').empty();
    $('#County').empty();
    $("#Province").append('<option value="">选择省</option>');
    $("#County").append('<option value="">选择县</option>');
    $("#City").append('<option value="">选择市</option>');
    $('#family').val("");
    $('#genus').val("");
    $('#species').val("");
    $.ajax({
        url: "species/adminRE2",
        type: "POST",
        data: {
            provinceId: provinceId,
            cityId: cityId,
            countyId: countyId,
            family: family,
            genus: genus,
            species: species
        },
        success: function(data) {
            $.each(data, function(index, city) {
                $("#Province").append('<option value="' + city.Id + '">' + city.cityName + '</option>');
            });
            var table = $("#myTable");
            table.find("tbody").empty();
            var table = $("#aliasTable");
            table.find("tbody").empty();
        },
        error: function(xhr, status, error) {
            alert("已添加过此种名");
            console.log("Ajax请求失败：" + error);
            console.log(xhr);
            console.log(status);
        }
    });
}

function onclickupd2() {
    var provinceId = document.getElementById("Province").value;
    var cityId = document.getElementById("City").value;
    var countyId = document.getElementById("County").value;
    var family = document.getElementById("family").value;
    var genus = document.getElementById("genus").value;
    var species = document.getElementById("species").value;
    $('#Province').empty();
    $('#City').empty();
    $('#County').empty();
    $("#Province").append('<option value="">选择省</option>');
    $("#County").append('<option value="">选择县</option>');
    $("#City").append('<option value="">选择市</option>');
    $('#family').val("");
    $('#genus').val("");
    $('#species').val("");
    $.ajax({
        url: "species/adminRE3",
        type: "POST",
        data: {
            provinceId: provinceId,
            cityId: cityId,
            countyId: countyId,
            family: family,
            genus: genus,
            species: species
        },
        success: function(data) {
            var dayj = 0;
            $.each(data, function(index, city) {
                if(!dayj) {
                    dayj = 1;
                    var table = $("#myTable");
                    var row = $("<tr>");
                    // 创建表格单元格并设置内容
                    var cell1 = $("<td>").text(city.Id);
                    var cell2 = $("<td>").text(city.cityName);
                    // 将单元格添加到行中
                    row.append(cell1, cell2);
                    // 将行添加到表格的tbody中
                    table.find("tbody").append(row);
                }
                else {
                    $("#Province").append('<option value="' + city.Id + '">' + city.cityName + '</option>');
                }
            });
                // 创建新的表格行


            console.log(2000);
        },
        error: function(xhr, status, error) {
            console.log("Ajax请求失败：" + error);
            console.log(xhr);
            console.log(status);
        }
    });
}

function onclickupd3() {
    var alias = document.getElementById("alias").value;
    $('#alias').val("");
    $.ajax({
        url: "species/adminRE4",
        type: "POST",
        data: {
            alias: alias
        },
        success: function(data) {
            var table = $("#aliasTable");
            var row = $("<tr>");
            var cell1 = $("<td>").text(data.alias);
            row.append(cell1);
            table.find("tbody").append(row);
        },
        error: function(xhr, status, error) {
            console.log("Ajax请求失败：" + error);
            console.log(xhr);
            console.log(status);
        }
    });
}

function onclickselect1() {
    console.log(6000);
    var provinceId = document.getElementById("Province").value;
    var cityId = document.getElementById("City").value;
    var countyId = document.getElementById("County").value;
    var family = document.getElementById("family").value;
    var genus = document.getElementById("genus").value;
    var species = document.getElementById("species").value;
    var alias = document.getElementById("alias").value;
    $.ajax({
        url: "species/adminRE7",
        type: "POST",
        data: {
            provinceId: provinceId,
            cityId: cityId,
            countyId: countyId,
            family: family,
            genus: genus,
            species: species,
            alias: alias
        },
        success: function(data) {
            console.log(500);
            var tableContainer = document.getElementById("tableContainer");
            var table = document.createElement("table");
            var thead = document.createElement("thead");
            var headerRow = document.createElement("tr");
            headerRow.innerHTML = "<th>物种名称</th><th>科</th><th>属</th><th>地区</th><th>别名</th>";
            thead.appendChild(headerRow);
            table.appendChild(thead);
            var tbody = document.createElement("tbody");
            data.forEach(function(species) {
                var row = document.createElement("tr");
                var speciesNameCell = document.createElement("td");
                speciesNameCell.textContent = species.speciesName;
                row.appendChild(speciesNameCell);
                var familyCell = document.createElement("td");
                familyCell.textContent = species.familyName;
                row.appendChild(familyCell);
                var genusCell = document.createElement("td");
                genusCell.textContent = species.genusName;
                row.appendChild(genusCell);
                var areasCell = document.createElement("td");
                areasCell.textContent = species.areas.join(", ");
                row.appendChild(areasCell);
                var aliasesCell = document.createElement("td");
                aliasesCell.textContent = species.aliases.join(", ");
                row.appendChild(aliasesCell);
                tbody.appendChild(row);
            });
            table.appendChild(tbody);
            tableContainer.innerHTML = "";
            tableContainer.appendChild(table);
        },
        error: function(xhr, status, error) {
            console.log("Ajax请求失败：" + error);
            console.log(xhr);
            console.log(status);
        }
    });
}

function onclickselect12() {
    console.log(3302);
}
